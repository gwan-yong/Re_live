import 'dart:io';

import 'package:drift/drift.dart'as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:re_live/widget/common/bottom_area.dart';
import 'package:re_live/widget/common/card_circular_carousel.dart';
import '../controller/card_carousel_controller.dart';
import '../controller/select_schedule_controller.dart';
import '../database/drift_database.dart';
import '../widget/fab_menu_button.dart';



class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalDatabase database = LocalDatabase();
  final DateTime selectedDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            top: true,
            bottom: false,
            child: Container(
              margin: EdgeInsets.all(0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _title(),
                    Obx(() {
                      final selectedDate = SelectScheduleController.to.selectDate.value;
                      return CardCircularCarousel(
                        key: ValueKey(selectedDate),
                        scale: CardCarouselController.to.cardCarouselScale.value,
                        cardPadding: CardCarouselController.to.cardPadding.value,

                      );
                    }),
                    BottomArea(
                      onCalendarOpened: () {
                        setState(() {
                          CardCarouselController.to.setScale (0.7);
                        });
                      },
                      onCalendarClosed: () {
                        setState(() {
                          CardCarouselController.to.setScale (1.0);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          //FAButtonMenu(),
        ],
      ),
    );
  }


  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              /*await insertTestSchedules();
              await insertTestCompletedSchedules();
              await insertSampleJournals();
              _printAllSchedules();*/

                //CardCarouselController.to.setScale (1);
                //CardCarouselController.to.setCardPadding(00);
            },
            child: Text(
              'ReLive',
              style: TextStyle(fontSize: 50.0),
            ),
          ),
        ],
      ),
    );
  }
}


Future<void> insertTestSchedules() async {
  final db = LocalDatabase();

  // 반복 일정 (5월 27일부터 8월 말까지)
  final DateTime repeatStartDate = DateTime(2025, 5, 27);
  final DateTime repeatEndDate = DateTime(2025, 8, 31);

  final List<UpcomingScheduledCompanion> repeatSchedules = [
    UpcomingScheduledCompanion.insert(
      title: '기상 ☀️',
      color: drift.Value(0xFFFFD54F),
      date: repeatStartDate,
      startTime: 8 * 60, // 8:00
      endUsed: false,
      endTime: drift.Value(null),
      repeatType: drift.Value('매일'),
      repeatEndUsed: drift.Value(true),
      repeatEndDate: drift.Value(repeatEndDate),
    ),
    UpcomingScheduledCompanion.insert(
      title: '점심 시간! 뭐 먹지?',
      color: drift.Value(0xFF4FC3F7),
      date: repeatStartDate,
      startTime: 13 * 60, // 13:00
      endUsed: false,
      endTime: drift.Value(null),
      repeatType: drift.Value('매일'),
      repeatEndUsed: drift.Value(true),
      repeatEndDate: drift.Value(repeatEndDate),
    ),
    UpcomingScheduledCompanion.insert(
      title: '저녁 냠냠 🍲',
      color: drift.Value(0xFFA1887F),
      date: repeatStartDate,
      startTime: 19 * 60, // 19:00
      endUsed: false,
      endTime: drift.Value(null),
      repeatType: drift.Value('매일'),
      repeatEndUsed: drift.Value(true),
      repeatEndDate: drift.Value(repeatEndDate),
    ),
  ];

  // 반복 없는 일정
  final List<UpcomingScheduledCompanion> nonRepeatSchedules = [
    UpcomingScheduledCompanion.insert(
      title: '수업 듣다 영혼 가출 👻',
      color: drift.Value(0xFFBA68C8),
      date: DateTime(2025, 5, 29),
      startTime: 10 * 60,
      endUsed: false,
      endTime: drift.Value(null),
    ),
    UpcomingScheduledCompanion.insert(
      title: '넷플릭스 정주행 시작 🎬',
  color: drift.Value(0xFFE57373),
      date: DateTime(2025, 5, 30),
      startTime: 20 * 60,
      endUsed: false,
      endTime: drift.Value(null),
    ),
    UpcomingScheduledCompanion.insert(
      title: '멋지게 발표하기✨',
      color: drift.Value(0xFFFFF176),
      date: DateTime(2025, 5, 31),
      startTime: 17 * 60,
      endUsed: false,
      endTime: drift.Value(null),
    ),
    UpcomingScheduledCompanion.insert(
      title: '빡코딩!🥶',
      color: drift.Value(0xFF81D4FA),
      date: DateTime(2025, 6, 1),
      startTime: 19 * 60 + 30,
      endUsed: true,
      endTime: drift.Value(22 * 60 + 30),
    ),
    UpcomingScheduledCompanion.insert(
      title: '코딩 공부📚',
      color: drift.Value(0xFF4DB6AC),
      date: DateTime(2025, 6, 2),
      startTime: 1 * 60 + 10,
      endUsed: true,
      endTime: drift.Value(4 * 60),
    ),
    UpcomingScheduledCompanion.insert(
      title: '유튜브와 함께해 🎬',
      date: DateTime(2025, 6, 2),
      color: drift.Value(0xFFFF8A65),
      startTime: 20 * 60,
      endUsed: false,
      endTime: drift.Value(null),
    ),
    UpcomingScheduledCompanion.insert(
      title: '수업 듣다 영혼 가출 👻',
      color: drift.Value(0xFFBA68C8),
      date: DateTime(2025, 6, 3),
      startTime: 10 * 60,
      endUsed: false,
      endTime: drift.Value(null),
    ),
    UpcomingScheduledCompanion.insert(
      title: '친구들과 즐거운 시간! 🍻',
      color: drift.Value(0xFFFFB74D),
      date: DateTime(2025, 6, 3),
      startTime: 20 * 60,
      endUsed: true,
      endTime: drift.Value(23 * 60),
    ),
  ];

  for (final schedule in repeatSchedules) {
    await db.insertSchedule(schedule);
  }

  for (final schedule in nonRepeatSchedules) {
    await db.insertSchedule(schedule);
  }

  print('테스트 일정 삽입 완료!');
}

Future<String> copyAssetToLocalPath(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);
  final tempDir = await getTemporaryDirectory();
  final fileName = assetPath.split('/').last;
  final file = File('${tempDir.path}/$fileName');
  await file.writeAsBytes(byteData.buffer.asUint8List());
  return file.path;
}

Future<void> insertTestCompletedSchedules() async {
  final db = LocalDatabase();

  // Assets를 내부 경로로 복사
  final food1Path = await copyAssetToLocalPath('assets/img/sample2.jpeg');
  final food2Path = await copyAssetToLocalPath('assets/img/sample3.jpeg');
  final food3Path = await copyAssetToLocalPath('assets/img/sample4.jpeg');
  final food4Path = await copyAssetToLocalPath('assets/img/sample7.jpeg');
  final face1Path = await copyAssetToLocalPath('assets/img/face1.jpg');
  final face2Path = await copyAssetToLocalPath('assets/img/face2.jpg');
  final face3Path = await copyAssetToLocalPath('assets/img/face3.jpg');
  final lectureFPath = await copyAssetToLocalPath('assets/img/lectureF.jpg');
  final lectureRPath = await copyAssetToLocalPath('assets/img/lectureR.jpg');
  final MoningFPath = await copyAssetToLocalPath('assets/img/moningF.jpg');
  final MoningRPath = await copyAssetToLocalPath('assets/img/moningR.jpg');
  final projectPath = await copyAssetToLocalPath('assets/img/project.JPG');
  final youtubeRPath = await copyAssetToLocalPath('assets/img/youtubeR.jpg');
  final youtubeFPath = await copyAssetToLocalPath('assets/img/youtubeF.jpg');
  final friendsRPath = await copyAssetToLocalPath('assets/img/friendsR.jpg');
  final friendsFPath = await copyAssetToLocalPath('assets/img/friendsF.jpg');

  final List<CompletedScheduledCompanion> completedSchedules = [
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(1),
      frontImgPath: drift.Value(MoningFPath),
      rearImgPath: drift.Value(MoningRPath),
      takenAt: DateTime(2025, 5, 27, 8, 3),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(1),
      frontImgPath: drift.Value(MoningFPath),
      rearImgPath: drift.Value(MoningRPath),
      takenAt: DateTime(2025, 5, 28, 8, 3),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(1),
      frontImgPath: drift.Value(MoningFPath),
      rearImgPath: drift.Value(MoningRPath),
      takenAt: DateTime(2025, 5, 29, 8, 3),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(1),
      frontImgPath: drift.Value(MoningFPath),
      rearImgPath: drift.Value(MoningRPath),
      takenAt: DateTime(2025, 5, 30, 8, 3),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(1),
      frontImgPath: drift.Value(MoningFPath),
      rearImgPath: drift.Value(MoningRPath),
      takenAt: DateTime(2025, 5, 31, 8, 3),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(1),
      frontImgPath: drift.Value(MoningFPath),
      rearImgPath: drift.Value(MoningRPath),
      takenAt: DateTime(2025, 6, 1, 8, 3),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(1),
      frontImgPath: drift.Value(MoningFPath),
      rearImgPath: drift.Value(MoningRPath),
      takenAt: DateTime(2025, 6, 2, 8, 3),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(1),
      frontImgPath: drift.Value(MoningFPath),
      rearImgPath: drift.Value(MoningRPath),
      takenAt: DateTime(2025, 6, 3, 8, 3),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(1),
      frontImgPath: drift.Value(MoningFPath),
      rearImgPath: drift.Value(MoningRPath),
      takenAt: DateTime(2025, 6, 4, 8, 3),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(2),
      frontImgPath: drift.Value(food1Path),
      rearImgPath: drift.Value(MoningRPath),
      takenAt: DateTime(2025, 5, 27, 13, 10),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(2),
      frontImgPath: drift.Value(food1Path),
      rearImgPath: drift.Value(MoningRPath),
      takenAt: DateTime(2025, 5, 28, 13, 10),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(2),
      frontImgPath: drift.Value(food1Path),
      rearImgPath: drift.Value(face1Path),
      takenAt: DateTime(2025, 5, 29, 13, 10),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(2),
      frontImgPath: drift.Value(food1Path),
      rearImgPath: drift.Value(face1Path),
      takenAt: DateTime(2025, 5, 30, 13, 10),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(2),
      frontImgPath: drift.Value(food1Path),
      rearImgPath: drift.Value(face1Path),
      takenAt: DateTime(2025, 5, 31, 13, 10),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(2),
      frontImgPath: drift.Value(food1Path),
      rearImgPath: drift.Value(face1Path),
      takenAt: DateTime(2025, 6, 1, 13, 10),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(2),
      frontImgPath: drift.Value(food1Path),
      rearImgPath: drift.Value(face1Path),
      takenAt: DateTime(2025, 6, 2, 13, 10),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(2),
      frontImgPath: drift.Value(food1Path),
      rearImgPath: drift.Value(face1Path),
      takenAt: DateTime(2025, 6, 3, 13, 10),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(2),
      frontImgPath: drift.Value(food3Path),
      rearImgPath: drift.Value(face1Path),
      takenAt: DateTime(2025, 6, 4, 13, 10),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(3),
      frontImgPath: drift.Value(food2Path),
      rearImgPath: drift.Value(face2Path),
      takenAt: DateTime(2025, 5, 27, 19, 5),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(3),
      frontImgPath: drift.Value(food2Path),
      rearImgPath: drift.Value(face2Path),
      takenAt: DateTime(2025, 5, 28, 19, 5),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(3),
      frontImgPath: drift.Value(food2Path),
      rearImgPath: drift.Value(face2Path),
      takenAt: DateTime(2025, 5, 29, 19, 5),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(3),
      frontImgPath: drift.Value(food2Path),
      rearImgPath: drift.Value(face2Path),
      takenAt: DateTime(2025, 5, 30, 19, 5),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(3),
      frontImgPath: drift.Value(food2Path),
      rearImgPath: drift.Value(face2Path),
      takenAt: DateTime(2025, 5, 31, 19, 5),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(3),
      frontImgPath: drift.Value(food2Path),
      rearImgPath: drift.Value(face2Path),
      takenAt: DateTime(2025, 6, 1, 19, 5),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(3),
      frontImgPath: drift.Value(food2Path),
      rearImgPath: drift.Value(face2Path),
      takenAt: DateTime(2025, 6, 2, 19, 5),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(3),
      frontImgPath: drift.Value(food2Path),
      rearImgPath: drift.Value(face2Path),
      takenAt: DateTime(2025, 6, 3, 19, 5),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(4),
      frontImgPath: drift.Value(lectureFPath),
      rearImgPath: drift.Value(lectureRPath),
      takenAt: DateTime(2025, 5, 29, 10, 5),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(5),
      frontImgPath: drift.Value(youtubeFPath),
      rearImgPath: drift.Value(youtubeRPath),
      takenAt: DateTime(2025, 5, 30, 20, 30),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(6),
      frontImgPath: drift.Value(face2Path),
      rearImgPath: drift.Value(projectPath),
      takenAt: DateTime(2025, 5, 31, 17, 20),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(7),
      frontImgPath: drift.Value(face3Path),
      rearImgPath: drift.Value(projectPath),
      takenAt: DateTime(2025, 6, 1, 19, 35),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(8),
      frontImgPath: drift.Value(face3Path),
      rearImgPath: drift.Value(projectPath),
      takenAt: DateTime(2025, 6, 2, 1, 15),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(9),
      frontImgPath: drift.Value(youtubeFPath),
      rearImgPath: drift.Value(youtubeRPath),
      takenAt: DateTime(2025, 6, 2, 20, 10),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(10),
      frontImgPath: drift.Value(lectureFPath),
      rearImgPath: drift.Value(lectureRPath),
      takenAt: DateTime(2025, 6, 3, 10, 0),
    ),
    CompletedScheduledCompanion.insert(
      scheduledId: drift.Value(11),
      frontImgPath: drift.Value(friendsFPath),
      rearImgPath: drift.Value(friendsRPath),
      takenAt: DateTime(2025, 6, 3, 20, 45),
    ),
  ];

  for (final schedule in completedSchedules) {
    await db.insertCompleteSchedule(schedule);
  }

  print('완료된 테스트 일정 삽입 완료!');
}

Future<void> insertSampleJournals() async {
  final List<Map<String, String>> sampleJournals = [
    {'date': '2025-05-27', 'comment': '오늘은 새로운 프로젝트를 시작했다.'},
    {'date': '2025-05-28', 'comment': '하루 종일 회의만 했다. 조금 지쳤다.'},
    {'date': '2025-05-29', 'comment': '날씨가 좋아서 산책을 다녀왔다.'},
    {'date': '2025-05-30', 'comment': '개발한 기능을 테스트해봤는데 잘 작동한다!'},
    {'date': '2025-05-31', 'comment': '쉬는 날. 푹 쉬고 충전 완료.'},
    {'date': '2025-06-01', 'comment': '6월의 시작! 월간 목표를 정했다.'},
    {'date': '2025-06-02', 'comment': '버그 수정에 하루를 썼다. 원인을 찾는 게 어려웠다.'},
    {'date': '2025-06-03', 'comment': '마침내 기능 완성! 뿌듯하다.'},
  ];

  for (var entry in sampleJournals) {
    final parsedDate = DateTime.parse(entry['date']!);
    final dateWithTime = DateTime(parsedDate.year, parsedDate.month, parsedDate.day, 23, 0); // 오후 11시
    final comment = entry['comment']!;

    await LocalDatabase().insertJournal(JournalCompanion.insert(
      date: dateWithTime,
      comment: comment,
    ));
  }
}



void _printAllSchedules() async {
  final schedules1 = await LocalDatabase().getAllSchedules();
  for (final schedule in schedules1) {
    print(
      'ID: ${schedule.id},'
          ' Title: ${schedule.title},'
          ' COLOR: ${schedule.color},'
          ' Date: ${schedule.date}'
    );
  }

  final schedules2 = await LocalDatabase().getAllCompletePhotos();
  for (final schedule in schedules2) {
    print(
        'ID: ${schedule.id},'
            ' scheduledId: ${schedule.scheduledId},'

    );
  }
}