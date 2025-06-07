import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controller/db_complete_schedule_controller.dart';

import '../../controller/db_upcoming_schedule_controller.dart';
import 'complete_scheduled_card.dart';

class CompletedScheduledListItems {
  static List<Widget> build() {
    final schedules = DbCompleteScheduleController.to.completeSchedules;

    if (schedules.isEmpty) {
      return const [];
    }

    return schedules.map((schedule) {
      final String title = (schedule.scheduledId != null)
          ? (DbUpcomingScheduleController.to.getScheduleTitleById(schedule.scheduledId!) ?? '갑작스러운 일정')
          : '갑작스러운 일정';

      final color = Color(
        (schedule.scheduledId != null)
            ? (DbUpcomingScheduleController.to.getScheduleColorById(schedule.scheduledId!) ?? 0xFFCCCCCC)
            : 0xFFCCCCCC,
      );

      return CompleteScheduledCard(
        rearimgPath: schedule.rearImgPath,
        frontimgPath: schedule.frontImgPath,
        title: title,
        color: color,
        takenAt: DateFormat('a h:mm', 'ko').format(schedule.takenAt!),
        lateCommet: schedule.lateComment,
      );
    }).toList();
  }
}
