import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_color_picker/show_ios_color_picker.dart';
import 'package:re_live/widget/event_setting/date_setting.dart';
import 'package:re_live/widget/event_setting/repeat_setting.dart';
import '../database/drift_database.dart';
import '../theme/colors.dart';
import '../widget/event_setting/event_title.dart';
import 'package:drift/drift.dart' as drift;
import 'home_screen.dart';

class EventScreen extends StatefulWidget {
  State<EventScreen> createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen> {
  Color backgroundColor = appBackgroundColor;
  IOSColorPickerController iosColorPickerController =
  IOSColorPickerController();

  String title = '';
  int color = 1;
  DateTime selectedDate = DateTime.now();
  int startTime = 480; // 8:00
  bool endUsed = false;
  int endTime = 540;   // 9:00
  String repeatType = 'none';
  bool repeatEndUsed = false;
  DateTime repeatEndDate = DateTime.now();

  final LocalDatabase db = LocalDatabase();

  void _printAllSchedules(LocalDatabase db) async {
    final schedules = await db.getAllSchedules();
    for (final schedule in schedules) {
      print('ID: ${schedule.id},'
          ' Title: ${schedule.title},'
          ' COLOR: ${schedule.color},'
          ' Date: ${schedule.date}'
          ' startTime: ${schedule.startTime},'
          ' endUsed: ${schedule.endUsed},'
          ' endTime: ${schedule.endTime},'
          ' repeatType: ${schedule.repeateType},'
          ' repeatEndUsed: ${schedule.repeatEndUsed},'
          ' repeatEndDate: ${schedule.repeatEndDate},'
      );
    }
  }

  @override
  void dispose() {
    iosColorPickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: Text("일정"), backgroundColor: backgroundColor),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EventTitle(
                  backgroundColor: backgroundColor,
                  onColorChanged: (color) {
                    setState(() => backgroundColor = color);
                  },
                  onTitleChanged: (value) {
                    title = value;
                  },
                ),
                DateSetting(
                  onStartChanged: (date, time) {
                    setState(() {
                      if (date != null) {
                        selectedDate = date;
                      }
                      if (time != null) {
                        // TimeOfDay를 분 단위로 변환
                        startTime = time.hour * 60 + time.minute;
                      }
                      print(selectedDate);
                      print(startTime);
                    });
                  },
                  onEndChanged: (time) {
                    setState(() {
                      if (time != null) {
                        endTime = time.hour * 60 + time.minute;
                      }
                      print(endTime);
                    });
                  },
                  onEndUsedChanged: (used) {
                    setState(() {
                      endUsed = used;
                      print(endUsed);
                    });
                  },
                ),
                RepeatSetting(
                  onRepeatTypeChanged: (type) {
                    setState(() {
                      repeatType = type;
                      print(type);
                    });
                  },
                  onRepeatEndUsedChanged: (used){
                    setState(() {
                      repeatEndUsed = used;
                      print(repeatEndUsed);
                    });
                  },
                  onRepeatEndDateChanged: (date) {
                    setState(() {
                      if(date != null) {
                        repeatEndDate = date;
                      }
                      print(date);
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    final newSchedule = ScheduledCompanion(
                      title: drift.Value(title),
                      color: drift.Value(backgroundColor.value),
                      date: drift.Value(selectedDate),
                      startTime: drift.Value(startTime),
                      endUsed: drift.Value(endUsed),
                      endTime: drift.Value(endTime),
                      repeateType: drift.Value(repeatType),
                      repeatEndUsed: drift.Value(repeatEndUsed),
                      repeatEndDate: drift.Value(repeatEndDate),
                    );

                    await db.insertSchedule(newSchedule);

                    // 등록 완료 후 홈으로 이동
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                    _printAllSchedules(db);
                  },
                  child:
                  Container(
                    width: 348,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(child: Text('등록')),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

