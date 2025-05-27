import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:re_live/widget/event_setting/date_setting.dart';
import 'package:re_live/widget/event_setting/repeat_setting.dart';
import '../controller/db_complete_schedule_controller.dart';
import '../controller/db_schedule_controller.dart';
import '../controller/select_schedule_controller.dart';
import '../database/drift_database.dart';
import '../widget/event_setting/event_title.dart';
import 'package:drift/drift.dart' as drift;
import 'home_screen.dart';

class EventScreen extends StatefulWidget {
  EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  int timeOfDayToInt(TimeOfDay tod) => tod.hour * 60 + tod.minute;

  bool _isValid() {
    return SelectScheduleController.to.title.value.trim().isNotEmpty;
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

  bool _showDeleteOptions = false;

  @override
  void dispose() {
    // 화면이 사라질 때 초기화 실행
    SelectScheduleController.to.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final backgroundColor = SelectScheduleController.to.color.value;

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
                    EventTitle(),
                    DateSetting(),
                    RepeatSetting(),
                    const SizedBox(height: 30),
                    //삭제 옵션 버튼 표시
                    if (_showDeleteOptions)
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final id = SelectScheduleController.to.id.value;

                              final newCompleteSchedule =
                                  (CompletedScheduledCompanion(
                                    scheduledId: drift.Value(id),
                                    takenAt: drift.Value(
                                      SelectScheduleController
                                          .to
                                          .selectDate
                                          .value,
                                    ),
                                    notDisplay: drift.Value(true),
                                  ));

                              // CompletePhotos 테이블에 데이터 추가
                              await DbCompleteScheduleController.to
                                  .addCompleteSchedule(newCompleteSchedule);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            },
                            child: Container(
                              width: 350,
                              height: 50,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: Text(
                                  '이 일정만 삭제',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //반복 되는 모든 일정 삭제 하는 버튼
                          GestureDetector(
                            onTap: () async {
                              final id = SelectScheduleController.to.id.value;
                              await DbScheduleController.to.deleteSchedule(id);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            },
                            child: Container(
                              width: 350,
                              height: 50,
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: Text(
                                  '모든 반복 삭제',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final bool hasValidId =
                                  SelectScheduleController.to.id.value >= 1;
                              if (hasValidId) {
                                ScheduledData? schedule =
                                await DbScheduleController.to
                                    .searchSchedule(
                                  SelectScheduleController.to.id.value,
                                );
                                //반복하지 않는 일정
                                final isRepeatNone =
                                    schedule?.repeatType == "없음";
                                if (isRepeatNone) {
                                  await DbScheduleController.to.deleteSchedule(
                                    schedule!.id,
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _showDeleteOptions =
                                    !_showDeleteOptions; // 상태 토글
                                  });
                                }
                              }
                            },
                            child: Container(
                              width: 168,
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
                                  _showDeleteOptions ? '취소' : '삭제', //텍스트 전환
                                  style: TextStyle(
                                    color:
                                        _isValid()
                                            ? Colors.black
                                            : Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                                      SelectScheduleController
                                          .to
                                          .color
                                          .value
                                          .value,
                                    ),
                                    date: drift.Value(
                                      SelectScheduleController
                                          .to
                                          .selectDate
                                          .value,
                                    ),
                                    startTime: drift.Value(
                                      timeOfDayToInt(
                                        SelectScheduleController
                                            .to
                                            .startTime
                                            .value,
                                      ),
                                    ),
                                    endUsed: drift.Value(
                                      SelectScheduleController.to.endUsed.value,
                                    ),
                                    endTime:
                                        SelectScheduleController
                                                    .to
                                                    .endTime
                                                    .value ==
                                                null
                                            ? const drift.Value.absent()
                                            : drift.Value(
                                              timeOfDayToInt(
                                                SelectScheduleController
                                                    .to
                                                    .endTime
                                                    .value!,
                                              ),
                                            ),
                                    repeatType: drift.Value(
                                      SelectScheduleController
                                          .to
                                          .repeatType
                                          .value,
                                    ),
                                    repeatEndUsed: drift.Value(
                                      SelectScheduleController
                                          .to
                                          .repeatEndUsed
                                          .value,
                                    ),
                                    repeatEndDate: drift.Value(
                                      SelectScheduleController
                                          .to
                                          .repeatEndDate
                                          .value,
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
                                  // 버튼 누른 후 reset()은 dispose()에서 이미 호출하므로 생략 가능
                                },
                                child: Container(
                                  width: 168,
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
                                            _isValid()
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
