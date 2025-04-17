import 'package:flutter/material.dart';
import 'package:re_live/widget/event_setting/date_picker_box.dart';
import '../../theme/colors.dart';

class DateSetting extends StatefulWidget {
  const DateSetting({super.key});

  @override
  State<DateSetting> createState() => _DateSettingState();
}

class _DateSettingState extends State<DateSetting> {
  bool endDayUsed = false;

  Widget build(BuildContext context) {
    return Container(
      height: 233,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
              child: DatePickerBox(),
            ),
            Container(
              height: 0.5,
              width: double.infinity,
              color: secondaryColor,
            ),
            const SizedBox(
              height: 8,
            ),
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
                    endDayUsed = !endDayUsed; // 버튼 누를 때 상태 전환
                  });
                },
                child: Container(
                  width: 70,
                  height: 29,
                  decoration: BoxDecoration(
                    color: endDayUsed ? Colors.green : Colors.grey, // 색상 변경,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      endDayUsed ? '사용' : '미사용',
                      style: TextStyle(
                          fontSize: 18, color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: DatePickerBox(),
            ),
          ],
        ),
      ),
    );
  }
}
