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
  final DateTime initialDate;

  EventScreen({
    Key? key,
    DateTime? initialDate, // 선택 매개변수로 변경
  }) : initialDate =
           initialDate ??
           DateTime(
             DateTime.now().year,
             DateTime.now().month,
             DateTime.now().day,
           ),
       // 값이 없으면 현재 날짜 사용
       super(key: key);

  @override
  State<EventScreen> createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen> {
  Color backgroundColor = appBackgroundColor;
  IOSColorPickerController iosColorPickerController =
      IOSColorPickerController();

  String title = '';
  int color = 1;

  late DateTime selectedDate;
  int startTime = 480; // 8:00
  bool endUsed = false;
  int endTime = 540; // 9:00

  String repeatType = '없음';
  bool repeatEndUsed = false;
  late DateTime repeatEndDate;

  final LocalDatabase db = LocalDatabase();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    repeatEndDate = widget.initialDate;
  }

  void _printAllSchedules(LocalDatabase db) async {
    final schedules = await db.getAllSchedules();
    for (final schedule in schedules) {
      print(
        'ID: ${schedule.id},'
        ' Title: ${schedule.title},'
        ' COLOR: ${schedule.color},'
        ' Date: ${schedule.date}'
        ' startTime: ${schedule.startTime},'
        ' endUsed: ${schedule.endUsed},'
        ' endTime: ${schedule.endTime},'
        ' repeatType: ${schedule.repeatType},'
        ' repeatEndUsed: ${schedule.repeatEndUsed},'
        ' repeatEndDate: ${schedule.repeatEndDate},',
      );
    }
  }

  bool _isValid() {
    return title.trim().isNotEmpty;
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
      body: SingleChildScrollView(
        child: SafeArea(
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
                      setState(() {
                        title = value;
                      });
                    },
                  ),
                  DateSetting(
                    initialDate: selectedDate,
                    onStartChanged: (date, time) {
                      setState(() {
                        if (date != null) {
                          selectedDate = date;
                        }
                        if (time != null) {
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
                    onRepeatEndUsedChanged: (used) {
                      setState(() {
                        repeatEndUsed = used;
                        print(repeatEndUsed);
                      });
                    },
                    onRepeatEndDateChanged: (date) {
                      setState(() {
                        if (date != null) {
                          repeatEndDate = date;
                        }
                        print(date);
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  AbsorbPointer(
                    absorbing: !_isValid(),
                    child: GestureDetector(
                      onTap: () async {
                        final newSchedule = ScheduledCompanion(
                          title: drift.Value(title),
                          color: drift.Value(backgroundColor.value),
                          date: drift.Value(selectedDate),
                          startTime: drift.Value(startTime),
                          endUsed: drift.Value(endUsed),
                          endTime: drift.Value(endTime),
                          repeatType: drift.Value(repeatType),
                          repeatEndUsed: drift.Value(repeatEndUsed),
                          repeatEndDate: drift.Value(repeatEndDate),
                        );

                        await db.insertSchedule(newSchedule);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                        _printAllSchedules(db);
                      },
                      child: Container(
                        width: 348,
                        height: 50,
                        decoration: BoxDecoration(
                          color:
                              _isValid()
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            '등록',
                            style: TextStyle(
                              color:
                                  _isValid() ? Colors.black : Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
