import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpcomingScheduleCard extends StatelessWidget {
  final String title;
  final int? startTime;
  final bool endUsed;
  final int? endTime;
  final Color color;
  final VoidCallback? onTap;
  final String? lateCommet;

  const UpcomingScheduleCard({
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
        height: double.infinity,
        padding: const EdgeInsets.all(13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 20)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_formatTime(startTime),style: const TextStyle(fontSize: 12)),
                if (endUsed) Text(" ~ ${_formatTime(endTime)}",style: const TextStyle(fontSize: 11)),
                if (lateCommet != null) Text(' 사유 : $lateCommet',style: const TextStyle(fontSize: 11)),
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