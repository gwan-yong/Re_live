import 'package:flutter/material.dart';

class DatePickerBox extends StatefulWidget {
  final bool withDate;
  final bool withTime;
  final Function(DateTime?, TimeOfDay?)? onDateTimeChanged;
  final DateTime? initialDate;
  final TimeOfDay? initialTime;

  const DatePickerBox({
    super.key,
    this.withDate = true,
    this.withTime = true,
    this.onDateTimeChanged,
    this.initialDate,
    this.initialTime,
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
    selectedDate = widget.initialDate;
    selectedTime = widget.initialTime;
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month, picked.day);
      });

      widget.onDateTimeChanged?.call(selectedDate, selectedTime);
    }
  }

  void _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
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
                      selectedDate != null
                          ? '${selectedDate!.year}.${selectedDate!.month.toString().padLeft(2, '0')}.${selectedDate!.day.toString().padLeft(2, '0')}'
                          : '날짜 선택',
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
                      : '시간 선택',
                  style: const TextStyle(fontSize: 18.0, color: Colors.black87),
                ),
              ),
            ),
          ),
      ],
    );
  }
}