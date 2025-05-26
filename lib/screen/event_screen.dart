import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ios_color_picker/show_ios_color_picker.dart';
import 'package:re_live/widget/event_setting/date_setting.dart';
import 'package:re_live/widget/event_setting/repeat_setting.dart';
import '../controller/db_schedule_controller.dart';
import '../controller/select_schedule_controller.dart';
import '../database/drift_database.dart';
import '../widget/event_setting/event_title.dart';
import 'package:drift/drift.dart' as drift;
import 'home_screen.dart';

class EventScreen extends StatefulWidget {
  EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen> {
  Color backgroundColor = SelectScheduleController.to.color.value;

  @override
  void initState() {
    super.initState();
  }

  void _printAllSchedules() async {
    final schedules = await LocalDatabase().getAllSchedules();
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

  int timeOfDayToInt(TimeOfDay tod) => tod.hour * 60 + tod.minute;

  bool _isValid() {
    return SelectScheduleController.to.title.value.trim().isNotEmpty;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final backgroundColor = SelectScheduleController.to.color.value;

      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text("일정"),
          backgroundColor: backgroundColor,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EventTitle(),
                    DateSetting(),
                    RepeatSetting(),
                    const SizedBox(height: 30),
                    Obx(
                          () => AbsorbPointer(
                        absorbing: !_isValid(),
                        child: GestureDetector(
                          onTap: () async {
                            final newSchedule = ScheduledCompanion(
                              title: drift.Value(
                                SelectScheduleController.to.title.value,
                              ),
                              color: drift.Value(
                                SelectScheduleController.to.color.value.value,
                              ),
                              date: drift.Value(
                                SelectScheduleController.to.selectDate.value,
                              ),
                              startTime: drift.Value(
                                timeOfDayToInt(
                                  SelectScheduleController.to.startTime.value,
                                ),
                              ),
                              endUsed: drift.Value(
                                SelectScheduleController.to.endUsed.value,
                              ),
                              endTime:
                              SelectScheduleController.to.endTime.value ==
                                  null
                                  ? const drift.Value.absent()
                                  : drift.Value(
                                timeOfDayToInt(
                                  SelectScheduleController
                                      .to.endTime.value!,
                                ),
                              ),
                              repeatType: drift.Value(
                                SelectScheduleController.to.repeatType.value,
                              ),
                              repeatEndUsed: drift.Value(
                                SelectScheduleController.to.repeatEndUsed.value,
                              ),
                              repeatEndDate: drift.Value(
                                SelectScheduleController.to.repeatEndDate.value,
                              ),
                            );

                            await DbScheduleController.to.addSchedule(
                              newSchedule,
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                            _printAllSchedules();
                            SelectScheduleController(); // 아마 이 줄은 초기화 목적이라면 수정 필요
                          },
                          child: Container(
                            width: 348,
                            height: 50,
                            decoration: BoxDecoration(
                              color: _isValid()
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                '등록',
                                style: TextStyle(
                                  color: _isValid()
                                      ? Colors.black
                                      : Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                ),
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
    });
  }
}
