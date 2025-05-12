import 'package:flutter/material.dart';

class DatePickerBox extends StatefulWidget {
  final bool withDate; // 날짜 선택 여부
  final bool withTime; // 시간 선택 여부
  final Function(DateTime?, TimeOfDay?)? onDateTimeChanged; // 선택 결과 전달
  final DateTime? initialDate;

  const DatePickerBox({
    super.key,
    this.withDate = true,
    this.withTime = true,
    this.onDateTimeChanged,
    this.initialDate,
  });

  @override
  State<DatePickerBox> createState() => _DatePickerBoxState();
}

class _DatePickerBoxState extends State<DatePickerBox> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    // 초기 값 설정: 현재 날짜와 시간
    //DateTime now = DateTime.now();
    selectedDate = widget.initialDate;
    selectedTime;
    //= TimeOfDay(hour: now.hour, minute: now.minute);  // 현재 시간 설정
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),  // selectedDate가 null인 경우 현재 날짜로 초기화
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month, picked.day);  // 선택된 날짜만 반영
      });

      widget.onDateTimeChanged?.call(selectedDate, selectedTime);
    }
  }

  void _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),  // selectedTime이 null인 경우 현재 시간으로 초기화
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });

      widget.onDateTimeChanged?.call(selectedDate, selectedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.withDate)
          GestureDetector(
            onTap: _pickDate,
            child: Row(
              children: [
                Container(
                  height: 29,
                  width: 120,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      // 날짜가 null이 아니면 날짜를 포맷해서 출력
                      //'${selectedDate?.year.toString() ?? '선택 안됨'}.${selectedDate?.month.toString().padLeft(2, '0') ?? ''}.${selectedDate?.day.toString().padLeft(2, '0') ?? ''}',
                      selectedDate != null
                          ? '${selectedDate?.year.toString() ?? '선택 안됨'}.${selectedDate?.month.toString().padLeft(2, '0') ?? ''}.${selectedDate?.day.toString().padLeft(2, '0') ?? ''}'
                          : '날짜 선택',  // 날짜 선택이 안된 경우 '날짜 선택'을 표시
                      style: const TextStyle(fontSize: 18.0, color: Colors.black87),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
        if (widget.withTime)
          GestureDetector(
            onTap: _pickTime,
            child: Container(
              height: 29,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  selectedTime != null
                      ? selectedTime!.format(context)
                      : '시간 선택',  // 시간 선택이 안된 경우 '시간 선택'을 표시
                  style: const TextStyle(fontSize: 18.0, color: Colors.black87),
                ),
              ),
            ),
          ),
      ],
    );
  }
}