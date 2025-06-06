import 'dart:io';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:re_live/screen/camera_screen.dart';
import '../controller/db_complete_schedule_controller.dart';
import '../database/drift_database.dart';
import '../notification.dart';
import '../theme/colors.dart';
import '../widget/schedule/complete_scheduled_photo.dart';
import 'home_screen.dart';

class MissedScheduledScreen extends StatefulWidget {
  final int scheduledId;
  final String title;
  final String startTime;
  final bool endUsed;
  final String endTime;
  final Color color;

  const MissedScheduledScreen({
    Key? key,
    required this.scheduledId,
    required this.title,
    required this.startTime,
    required this.endUsed,
    required this.endTime,
    required this.color,
  }) : super(key: key);

  @override
  State<MissedScheduledScreen> createState() => _MissedScheduledScreenState();
}

class _MissedScheduledScreenState extends State<MissedScheduledScreen> {
  String rearImagePath = '';
  String frontImagePath = '';
  final TextEditingController _lateCommentController = TextEditingController();

  void _goToCameraScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(fromMissedEvent: true),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        rearImagePath = result['rearImagePath'] ?? '';
        frontImagePath = result['frontImagePath'] ?? '';
      });
    }
  }

  Future<String> _saveImageToInternalStorage(
    File imageFile,
    String label,
  ) async {
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("놓친 일정 기록"), backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 609,
                width: 330,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding:
                            rearImagePath != null && rearImagePath!.isNotEmpty
                                ? const EdgeInsets.all(1)
                                : const EdgeInsets.only(top: 5),
                        width: 500,
                        height: 589,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (rearImagePath != '' || frontImagePath != '')
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: CompleteScheduledPhoto(
                                    rearimgPath: rearImagePath,
                                    frontimgPath: frontImagePath,
                                  ),
                                ),
                              ),
                            if (rearImagePath == '' && frontImagePath == '')
                            GestureDetector(
                              onTap: _goToCameraScreen,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 10,
                                ),
                                width: 348,
                                height: 350,
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(child: Text('지금이라도 사진 등록 📸')),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                widget.title,
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(_getCurrentFormattedTime()),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text('일정을 기록하지 못한 사유'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: TextField(
                                controller: _lateCommentController,
                                onTapOutside:
                                    (event) =>
                                        FocusManager.instance.primaryFocus?.unfocus(),
                                minLines: 1,
                                maxLines: null,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: secondaryColor,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "코멘트...",
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () async {
                    // 텍스트 필드에 글자가 하나 이상 있어야 등록 가능
                    if (_lateCommentController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('코멘트를 입력해야 등록할 수 있어요!')),
                      );
                      return;
                    }

                    String? rearPath;
                    String? frontPath;

                    // rearImagePath가 비어있지 않으면 저장
                    if (rearImagePath.isNotEmpty) {
                      rearPath = await _saveImageToInternalStorage(
                        File(rearImagePath),
                        "rear",
                      );
                      print("저장된 후면 사진 경로: $rearPath");
                    }

                    // frontImagePath가 비어있지 않으면 저장
                    if (frontImagePath.isNotEmpty) {
                      frontPath = await _saveImageToInternalStorage(
                        File(frontImagePath),
                        "front",
                      );
                      print("저장된 전면 사진 경로: $frontPath");
                    }

                    // CompleteScheduled 테이블에 데이터 추가
                    final newCompleteSchedule = CompletedScheduledCompanion(
                      scheduledId: drift.Value(widget.scheduledId),
                      frontImgPath: drift.Value(frontPath ?? ''),
                      // 없으면 빈 문자열
                      rearImgPath: drift.Value(rearPath ?? ''),
                      // 없으면 빈 문자열
                      takenAt: drift.Value(DateTime.now()),
                      lateComment: drift.Value(
                        _lateCommentController.text.trim(),
                      ),
                    );

                    await DbCompleteScheduleController.to.addCompleteSchedule(
                      newCompleteSchedule,
                    );

                    // 알림 제거
                    await notifications.cancel(widget.scheduledId + 10000);
                    print('일정 완료 처리됨');

                    // 홈으로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    width: 330,
                    height: 50,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(child: Text('등록')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String _getCurrentFormattedTime() {
    final now = DateTime.now();
    return DateFormat.jm('ko').format(now);
  }
}
