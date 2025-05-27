import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleTile extends StatelessWidget {
  final String title;
  final int? startTime;
  final bool endUsed;
  final int? endTime;
  final Color color;
  final VoidCallback? onTap;
  final String? lateCommet;

  const ScheduleTile({
    required this.title,
    required this.startTime,
    required this.endUsed,
    required this.endTime,
    required this.color,
    this.onTap,
    this.lateCommet,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.infinity,
        height: 90,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 25)),
            Row(
              children: [
                Text(_formatTime(startTime)),
                if (endUsed) Text(" ~ ${_formatTime(endTime)}"),
                if (lateCommet != null) Text('사유 : $lateCommet'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int? minutes) {
    if (minutes == null) return '-';
    final hour = minutes ~/ 60;
    final minute = minutes % 60;
    final time = TimeOfDay(hour: hour, minute: minute);
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm('ko').format(dt);
  }
}