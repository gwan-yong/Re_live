import 'package:flutter/material.dart';
import 'package:re_live/theme/colors.dart';

import 'package:re_live/controller/select_schedule_controller.dart';

import 'date_picker_box.dart'; // 컨트롤러 import

enum RepeatType {
  none,
  daily,
  weekly,
  monthly,
  yearly,
}

class RepeatSetting extends StatefulWidget {
  const RepeatSetting({super.key});

  @override
  State<RepeatSetting> createState() => _RepeatSetting();
}

class _RepeatSetting extends State<RepeatSetting> {
  bool repeatDayUsed = false;
  RepeatType selectedType = RepeatType.none;
  DateTime? repeatEndDate;

  final Map<RepeatType, String> typeLabels = {
    RepeatType.none: '없음',
    RepeatType.daily: '매일',
    RepeatType.weekly: '매주',
    RepeatType.monthly: '매월',
    RepeatType.yearly: '매년',
  };

  @override
  void initState() {
    super.initState();

    // 🔹 반복 종료 사용 여부 초기화
    repeatDayUsed = SelectScheduleController.to.repeatEndUsed.value;

    // 🔹 반복 종료 날짜 초기화
    repeatEndDate = SelectScheduleController.to.repeatEndDate.value;

    // 🔹 반복 유형 초기화
    final repeatTypeLabel = SelectScheduleController.to.repeatType.value;
    final entry = typeLabels.entries
        .firstWhere((entry) => entry.value == repeatTypeLabel, orElse: () => const MapEntry(RepeatType.none, '없음'));
    selectedType = entry.key;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 233,
      width: 350,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 반복 유형 선택 영역
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '반복',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 6,
                  children: RepeatType.values.map((type) {
                    final isSelected = selectedType == type;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedType = type;
                        });
                        // 컨트롤러의 repeatType 업데이트
                        SelectScheduleController.to.repeatType.value = typeLabels[type]!;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          typeLabels[type]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 0.5,
                  width: double.infinity,
                  color: secondaryColor,
                ),
              ],
            ),

            // 반복 종료 설정 영역
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '반복 종료',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        repeatDayUsed = !repeatDayUsed;

                        // 컨트롤러 repeatEndUsed 업데이트
                        SelectScheduleController.to.repeatEndUsed.value = repeatDayUsed;

                        if (!repeatDayUsed) {
                          repeatEndDate = null;
                          SelectScheduleController.to.repeatEndDate.value = null;
                        }
                      });
                    },
                    child: Container(
                      width: 70,
                      height: 29,
                      decoration: BoxDecoration(
                        color: repeatDayUsed ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          repeatDayUsed ? '사용' : '미사용',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (repeatDayUsed)
                    DatePickerBox(
                      initialDate: repeatEndDate,
                      withTime: false,
                      onDateTimeChanged: (DateTime? date, TimeOfDay? _) {
                        setState(() {
                          repeatEndDate = date;
                        });

                        // 컨트롤러 repeatEndDate 업데이트
                        if (date != null) {
                          if (SelectScheduleController.to.repeatEndDate == null) {
                            SelectScheduleController.to.repeatEndDate.value = date;
                          } else {
                            SelectScheduleController.to.repeatEndDate!.value = date;
                          }
                        } else {
                          SelectScheduleController.to.repeatEndDate.value = null;
                        }
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}