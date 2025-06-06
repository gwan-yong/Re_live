import 'dart:io';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:re_live/controller/db_complete_schedule_controller.dart';
import 'package:re_live/controller/db_upcoming_schedule_controller.dart';
import '../database/drift_database.dart';
import '../notification.dart';
import '../theme/colors.dart';
import '../widget/schedule/complete_scheduled_card.dart';
import 'home_screen.dart'; // DB 접근을 위한 임포트

class PhotosUploadScreen extends StatelessWidget {
  final String rearImagePath;
  final String frontImagePath;

  const PhotosUploadScreen({
    required this.rearImagePath,
    required this.frontImagePath,
    Key? key,
  }) : super(key: key);

  void _printAllCompletePhotos() async {
    final CompletedPhotos = await LocalDatabase().getAllCompletePhotos();
    for (final completedPhoto in CompletedPhotos) {
      print(
          'ID: ${completedPhoto.id},'
              ' scheduledId: ${completedPhoto.scheduledId},'
              ' frontImgPath: ${completedPhoto.frontImgPath},'
              ' rearImgPath: ${completedPhoto.rearImgPath}'
              ' stakenAt : ${completedPhoto.takenAt },'
      );
    }
  }

  Future<String?> _saveImageToInternalStorage(File imageFile,
      String label) async {
    if (!await imageFile.exists()) {
      return null; // 파일이 없으면 null 반환
    }

    final dir = await getApplicationSupportDirectory();
    final photoDir = Directory('${dir.path}/app_data/photos');
    if (!await photoDir.exists()) {
      await photoDir.create(recursive: true);
    }

    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    final fileName = '${label}_$timestamp.jpg';

    final newPath = '${photoDir.path}/$fileName';
    final newFile = await imageFile.copy(newPath);

    return newFile.path;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UpcomingScheduledData?>(
      future: DbUpcomingScheduleController.to.getCurrentRunning(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('오류 발생: ${snapshot.error}')),
          );
        }

        final schedule = snapshot.data;

        final title = schedule?.title ?? '예정 없음';
        final color = Color(schedule?.color ?? 0xFFCCCCCC);


        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("사진 업로드"),
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 609,
                    width: 330,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CompleteScheduledCard(
                        rearimgPath: rearImagePath,
                        frontimgPath: frontImagePath,
                        title: title,
                        color: color,
                        takenAt: _getCurrentFormattedTime(),
                        bigFont: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    // 이미지 저장 경로 얻기
                    final rearPath = await _saveImageToInternalStorage(
                        File(rearImagePath), "rear");
                    final frontPath = await _saveImageToInternalStorage(
                        File(frontImagePath), "front");

                    print("저장된 후면 사진 경로: $rearPath");
                    print("저장된 전면 사진 경로: $frontPath");


                    // _getCurrentRunningSchedule에서 scheduledId 가져오기
                    final currentSchedule = await DbUpcomingScheduleController
                        .to.getCurrentRunning();

                    final newCompleteSchedule = (CompletedScheduledCompanion(
                      scheduledId: drift.Value(currentSchedule?.id),
                      frontImgPath: drift.Value(frontPath),
                      rearImgPath: drift.Value(rearPath),
                      takenAt: drift.Value(DateTime.now()),
                    ));

                    // CompletePhotos 테이블에 데이터 추가
                    await DbCompleteScheduleController.to.addCompleteSchedule(
                        newCompleteSchedule);


                    if (currentSchedule != null) {
                      await notifications.cancel(
                          currentSchedule.id + 10000); // 해당 ID의 놓친 일정 알림 삭제
                      print('일정 완료 처리됨');
                    } else {
                      print('현재 진행 중인 일정이 없습니다.');
                    }

                    _printAllCompletePhotos();

                    //저장 후 HomeScreen으로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0),
                    width: 348,
                    height: 50,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(child: Text('등록')),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  // 현재 시간을 "오전 11:03" 같은 형식으로 리턴
  String _getCurrentFormattedTime() {
    final now = DateTime.now();
    return DateFormat.jm('ko').format(now);
  }

}