import 'package:flutter/material.dart';
import 'package:re_live/controller/select_schedule_controller.dart';
import 'package:re_live/widget/event_setting/date_picker_box.dart';
import '../../theme/colors.dart';

class DateSetting extends StatefulWidget {
  final DateTime? initialDate;

  const DateSetting({
    super.key,
    this.initialDate,
  });

  @override
  State<DateSetting> createState() => _DateSettingState();
}

class _DateSettingState extends State<DateSetting> {
  bool endDayUsed = false;
  DateTime? startDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  @override
  void initState() {
    super.initState();

    // 컨트롤러의 기존 값을 불러옴
    startDate = SelectScheduleController.to.selectDate.value;
    startTime = SelectScheduleController.to.startTime.value;
    endDayUsed = SelectScheduleController.to.endUsed.value;
    endTime = SelectScheduleController.to.endTime?.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 233,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '시작 시간',
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: DatePickerBox(
                initialDate: startDate,
                initialTime: startTime,
                onDateTimeChanged: (date, time) {
                  setState(() {
                    startDate = date;
                    startTime = time;
                  });

                  if (date != null) {
                    SelectScheduleController.to.selectDate.value = date;
                  }
                  if (time != null) {
                    SelectScheduleController.to.startTime.value = time;
                  }
                },
              ),
            ),
            Container(
              height: 0.5,
              width: double.infinity,
              color: secondaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              '종료 시간',
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    endDayUsed = !endDayUsed;
                  });

                  // 컨트롤러 종료 사용 여부 반영
                  SelectScheduleController.to.endUsed.value = endDayUsed;

                  // 사용 안 할 경우 값 제거
                  if (!endDayUsed) {
                    SelectScheduleController.to.endTime.value = null;
                    endTime = null;
                  }
                },
                child: Container(
                  width: 70,
                  height: 29,
                  decoration: BoxDecoration(
                    color: endDayUsed ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      endDayUsed ? '사용' : '미사용',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            if (endDayUsed)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: DatePickerBox(
                  withDate: false,
                  initialTime: endTime, // ✅ 종료 시간 초기값 전달
                  onDateTimeChanged: (date, time) {
                    setState(() {
                      endTime = time;
                    });

                    if (time != null) {
                      if (SelectScheduleController.to.endTime == null) {
                        SelectScheduleController.to.endTime.value = time;
                      } else {
                        SelectScheduleController.to.endTime!.value = time;
                      }
                    } else {
                      SelectScheduleController.to.endTime.value = null;
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}