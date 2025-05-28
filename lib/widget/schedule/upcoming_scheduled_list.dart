import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:re_live/widget/schedule/schedule_tile.dart';
import '../../controller/db_upcoming_schedule_controller.dart';
import '../../controller/notification_controller.dart';
import '../../controller/select_schedule_controller.dart';
import '../../screen/scheduled_detail_screen.dart';

class UpcomingScheduledList extends StatelessWidget {
  final bool isScrollable;
  final DateTime selectedDate = SelectScheduleController.to.selectDate.value;

  UpcomingScheduledList({this.isScrollable = true}) {
    NotificationController.to.loadTodaySchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final schedules = DbUpcomingScheduleController.to.upcomingSchedules;

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
            final color = Color(schedule.color ?? 0xFFCCCCCC);

            return ScheduleTile(
              title: schedule.title,
              startTime: schedule.startTime,
              endUsed: schedule.endUsed,
              endTime: schedule.endTime,
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
      MaterialPageRoute(builder: (context) => ScheduledDetailScreen()),
    );
  }

  TimeOfDay? _intToTimeOfDay(int? minutes) {
    if (minutes == null) return null;
    return TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
  }
}
