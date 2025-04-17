import 'package:flutter/material.dart';

class DatePickerBox extends StatefulWidget {
  final bool withTime; // 시간 선택을 포함할지 여부

  const DatePickerBox({super.key, this.withTime = true});

  @override
  State<DatePickerBox> createState() => _DatePickerBoxState();
}

class _DatePickerBoxState extends State<DatePickerBox> {
  List<DateTime?> selectedDates = [null];      // 날짜만 저장
  List<TimeOfDay?> selectedTimes = [null];     // 시간만 저장 (시간 선택이 있을 때만 사용)

  void _pickDate(int index) async {
    DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDates[index] ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDates[index] = picked;
      });
    }
  }

  void _pickTime(int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTimes[index] ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTimes[index] = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(selectedDates.length, (index) {
        return Row(
          children: [
            // 날짜 선택 박스
            GestureDetector(
              onTap: () => _pickDate(index),
              child: Container(
                height: 29,
                width: 120,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    selectedDates[index] == null
                        ? '날짜 선택'
                        : '${selectedDates[index]!.year}.${selectedDates[index]!.month.toString().padLeft(2, '0')}.${selectedDates[index]!.day.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // 시간 선택이 필요한 경우에만 표시
            if (widget.withTime)
              GestureDetector(
                onTap: () => _pickTime(index),
                child: Container(
                  height: 29,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      selectedTimes[index] == null
                          ? '시간 선택'
                          : selectedTimes[index]!.format(context),
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}