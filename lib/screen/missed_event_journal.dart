import 'dart:io';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:re_live/screen/camera_screen.dart';
import '../controller/db_complete_schedule_controller.dart';
import '../database/drift_database.dart';
import '../notification.dart';
import '../theme/colors.dart';
import 'home_screen.dart';

class MissedEventJournal extends StatefulWidget {
  final int scheduledId;
  final String title;
  final String startTime;
  final bool endUsed;
  final String endTime;
  final Color color;

  const MissedEventJournal({
    Key? key,
    required this.scheduledId,
    required this.title,
    required this.startTime,
    required this.endUsed,
    required this.endTime,
    required this.color,
  }) : super(key: key);

  @override
  State<MissedEventJournal> createState() => _MissedEventJournalState();
}

class _MissedEventJournalState extends State<MissedEventJournal> {
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("놓친 일정 기록"), backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text('소화하지 못한 일정'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: double.infinity,
                height: 90,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: TextStyle(fontSize: 25)),
                    Row(
                      children: [
                        Text(widget.startTime),
                        if (widget.endUsed) Text(" ~ ${widget.endTime}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text('일정을 기록하지 못한 사유'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _lateCommentController,
                onTapOutside:
                    (event) => FocusManager.instance.primaryFocus?.unfocus(),
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
            if (rearImagePath != '' || frontImagePath != '')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: _PreviewPhotos(rearImagePath, frontImagePath),
                ),
              ),
            GestureDetector(
              onTap: _goToCameraScreen,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                width: 348,
                height: 50,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: Text('지금이라도 사진 등록 📸')),
              ),
            ),
            GestureDetector(
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
                  frontImgPath: drift.Value(frontPath ?? ''), // 없으면 빈 문자열
                  rearImgPath: drift.Value(rearPath ?? ''),   // 없으면 빈 문자열
                  takenAt: drift.Value(DateTime.now()),
                  lateComment: drift.Value(_lateCommentController.text.trim()),
                );

                await DbCompleteScheduleController.to.addCompleteSchedule(newCompleteSchedule);

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
                width: 348,
                height: 50,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(child: Text('놓친 일정 기록 등록')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _PreviewPhotos(String rearImagePath, String frontImagePath) {
    return SizedBox(
      width: 226,
      height: 328,
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
              child: Image.file(File(rearImagePath), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 10,
            child: Container(
              width: 85,
              height: 122,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.file(File(frontImagePath), fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}