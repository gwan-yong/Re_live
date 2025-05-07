/*
import 'package:flutter/material.dart';
import 'package:re_live/theme/colors.dart';
import 'package:re_live/widget/event_setting/date_picker_box.dart';

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

  // 각 반복 타입을 텍스트로 매핑
  final Map<RepeatType, String> typeLabels = {
    RepeatType.none: '없음',
    RepeatType.daily: '매일',
    RepeatType.weekly: '매주',
    RepeatType.monthly: '매월',
    RepeatType.yearly: '매년',
  };

  Widget build(BuildContext context) {
    return Container(
      height: 233,
      width: 350,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 233,
          width: 350,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '반복',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 20,
                        ),
                      ),
                      // 선택된 날짜를 보여주는 텍스트
                      Row(
                        children: [
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: RepeatType.values.map((type) {
                          final isSelected = selectedType == type;

                          return Padding(
                            padding: const EdgeInsets.only(right : 4),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedType = type; // 다른 버튼 선택 시 이전 버튼 자동 off
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.green : Colors.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  typeLabels[type]!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 0.5,
                        width: double.infinity,
                        color: secondaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                        '반복 종료',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            repeatDayUsed = !repeatDayUsed; // 버튼 누를 때 상태 전환
                          });
                        },
                        child: Container(
                          width: 70,
                          height: 29,
                          decoration: BoxDecoration(
                            color: repeatDayUsed ? Colors.green : Colors.grey, // 색상 변경,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              repeatDayUsed ? '사용' : '미사용',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // 선택된 날짜를 보여주는 텍스트
                      DatePickerBox(withTime: false),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:re_live/theme/colors.dart';
import 'package:re_live/widget/event_setting/date_picker_box.dart';

enum RepeatType {
  none,
  daily,
  weekly,
  monthly,
  yearly,
}

class RepeatSetting extends StatefulWidget {
  final Function(String)? onRepeatTypeChanged; // 반복 타입 변경 콜백
  final Function(bool) onRepeatEndUsedChanged; // 반복 종료 사용 변경 콜백
  final Function(DateTime?)? onRepeatEndDateChanged; // 반복 종료 날짜 변경 콜백

  const RepeatSetting({
    super.key,
    required this.onRepeatTypeChanged,
    required this.onRepeatEndUsedChanged,
    required this.onRepeatEndDateChanged,
  });

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
                        widget.onRepeatTypeChanged?.call(typeLabels[type]!);
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
                        if (!repeatDayUsed) {
                          repeatEndDate = null;
                          widget.onRepeatEndDateChanged?.call(null);
                        }
                      });
                      widget.onRepeatEndUsedChanged(repeatDayUsed);
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
                      withTime: false,
                      onDateTimeChanged: (DateTime? date, TimeOfDay? _) {
                        repeatEndDate = date;
                        widget.onRepeatEndDateChanged?.call(date);
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