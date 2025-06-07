import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/db_upcoming_schedule_controller.dart';
import '../../controller/notification_controller.dart';
import '../../controller/select_schedule_controller.dart';
import '../../screen/scheduled_detail_screen.dart';
import 'package:re_live/widget/scheduled_cards/upcoming_schedule_card.dart';

class UpcomingScheduledListItems {
  static List<Widget> build(BuildContext context) {
    // 알림 데이터 로드
    NotificationController.to.loadTodaySchedules();

    final schedules = DbUpcomingScheduleController.to.upcomingSchedules;

    if (schedules.isEmpty) {
      return [];
    }

    return schedules.map((schedule) {
      final color = Color(schedule.color ?? 0xFFCCCCCC);

      return UpcomingScheduleCard(
        title: schedule.title,
        startTime: schedule.startTime,
        endUsed: schedule.endUsed,
        endTime: schedule.endTime,
        color: color,
        onTap: () => _handleTap(context, schedule, color),
      );
    }).toList();
  }

  static void _handleTap(BuildContext context, schedule, Color color) {
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

  static TimeOfDay? _intToTimeOfDay(int? minutes) {
    if (minutes == null) return null;
    return TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
  }
}