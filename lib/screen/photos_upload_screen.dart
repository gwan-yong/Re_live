import 'dart:io';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../database/drift_database.dart';
import '../notification.dart';
import '../theme/colors.dart';
import 'home_screen.dart'; // DB 접근을 위한 임포트

class PhotosUploadScreen extends StatelessWidget {
  final String rearImagePath;
  final String frontImagePath;

  const PhotosUploadScreen({
    required this.rearImagePath,
    required this.frontImagePath,
    Key? key,
  }) : super(key: key);

  void _printAllCompletePhotos(LocalDatabase db) async {
    final CompletedPhotos = await db.getAllCompletePhotos();
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

  Future<String> _saveImageToInternalStorage(File imageFile, String label) async {
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
    final db = LocalDatabase(); // 이 줄이 핵심! 내부에서 DB 생성

    return FutureBuilder<ScheduledData?>(
      future: db.getCurrentRunningSchedule(),
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
        final startTime = schedule != null
            ? _formatTime(schedule.startTime)
            : _getCurrentFormattedTime();
        final endTime = schedule != null && schedule.endTime != null
            ? _formatTime(schedule.endTime!)
            : _getCurrentFormattedTime();
        final endUsed = schedule?.endUsed ?? false;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("사진 업로드"),
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: _PreviewPhotos(
                    rearImagePath: rearImagePath,
                    frontImagePath: frontImagePath,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25 , vertical: 1),
                  child: Text(
                      '업로드 할 일정'
                  ),
                ),
                _EventTile(title, startTime, endUsed, endTime, color),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    final db = LocalDatabase();
                    // 이미지 저장 경로 얻기
                    final rearPath = await _saveImageToInternalStorage(File(rearImagePath), "rear");
                    final frontPath = await _saveImageToInternalStorage(File(frontImagePath), "front");

                    print("저장된 후면 사진 경로: $rearPath");
                    print("저장된 전면 사진 경로: $frontPath");

                    // 현재 시간 구하기
                    final currentTime = DateTime.now();

                    // _getCurrentRunningSchedule에서 scheduledId 가져오기
                    final currentSchedule = await db.getCurrentRunningSchedule();

                    // CompletePhotos 테이블에 데이터 추가
                    await db.insertCompletePhoto(CompletedPhotosCompanion(
                      scheduledId: drift.Value(currentSchedule?.id),
                      frontImgPath: drift.Value(frontPath),
                      rearImgPath: drift.Value(rearPath),
                      takenAt: drift.Value(currentTime),
                    ));
                    if (currentSchedule != null) {
                      await notifications.cancel(currentSchedule.id + 10000); // 해당 ID의 놓친 일정 알림 삭제
                      print('일정 완료 처리됨');
                    } else {
                      print('현재 진행 중인 일정이 없습니다.');
                    }

                    _printAllCompletePhotos(db);

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

  // "오전 6:00" 같은 형식으로 시간 포맷
  String _formatTime(int rawTime) {
    final hour = rawTime ~/ 60;
    final minute = rawTime % 60;
    final time = TimeOfDay(hour: hour, minute: minute);
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm('ko').format(dt);
  }

  // 현재 시간을 "오전 11:03" 같은 형식으로 리턴
  String _getCurrentFormattedTime() {
    final now = DateTime.now();
    return DateFormat.jm('ko').format(now);
  }

  // 일정 박스
  Widget _EventTile(String title, String startTime, bool endUsed, String endTime, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      height: 90,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 25)),
          Row(
            children: [
              Text(startTime),
              if (endUsed) Text(" ~ $endTime"),
            ],
          ),
        ],
      ),
    );
  }
}

// 미리보기 사진 위젯
class _PreviewPhotos extends StatelessWidget {
  final String rearImagePath;
  final String frontImagePath;

  const _PreviewPhotos({
    required this.rearImagePath,
    required this.frontImagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 353,
      height: 463,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.file(
                File(rearImagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 10,
            child: Container(
              width: 133,
              height: 172,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.file(
                  File(frontImagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}