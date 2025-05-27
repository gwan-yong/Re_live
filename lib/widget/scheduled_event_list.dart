import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/db_schedule_controller.dart';
import '../controller/notification_controller.dart';
import '../controller/select_schedule_controller.dart';
import '../screen/event_screen.dart';

class ScheduledEventList extends StatelessWidget {
  final bool isScrollable;
  final DateTime selectedDate = SelectScheduleController.to.selectDate.value;

  ScheduledEventList({this.isScrollable = true}) {
    NotificationController.to.loadTodaySchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final schedules = DbScheduleController.to.schedules;

      if (schedules.isEmpty) {
        return const Center(child: Text('등록된 일정이 없습니다.'));
      }

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          physics: isScrollable
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: schedules.map((schedule) {
            final startTime = _formatTime(schedule.startTime);
            final endTime = _formatTime(schedule.endTime);
            final color = Color(schedule.color ?? 0xFFCCCCCC);

            return EventTile(
              title: schedule.title,
              startTime: startTime,
              endUsed: schedule.endUsed,
              endTime: endTime,
              color: color,
              onTap: () => _handleTap(context, schedule, color),
            );
          }).toList(),
        ),
      );
    });
  }

  void _handleTap(BuildContext context, schedule, Color color) {
    final controller = SelectScheduleController.to;

    controller.id.value = schedule.id;
    controller.title.value = schedule.title;
    controller.color.value = color;
    controller.startTime.value = _intToTimeOfDay(schedule.startTime)!;
    controller.endUsed.value = schedule.endUsed;
    controller.endTime.value = _intToTimeOfDay(schedule.endTime);
    controller.repeatType.value = schedule.repeatType;
    controller.repeatEndUsed.value = schedule.repeatEndUsed;
    controller.repeatEndDate.value = schedule.repeatEndDate;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventScreen()),
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

  TimeOfDay? _intToTimeOfDay(int? minutes) {
    if (minutes == null) return null;
    return TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
  }
}

class EventTile extends StatelessWidget {
  final String title;
  final String startTime;
  final bool endUsed;
  final String endTime;
  final Color color;
  final VoidCallback onTap;

  const EventTile({
    required this.title,
    required this.startTime,
    required this.endUsed,
    required this.endTime,
    required this.color,
    required this.onTap,
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
                Text(startTime),
                if (endUsed) Text(" ~ $endTime"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}