import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_live/widget/schedule_tile.dart';

import '../controller/db_complete_schedule_controller.dart';
import '../controller/db_schedule_controller.dart';

class MissedEventList extends StatelessWidget {
  final bool isScrollable; // 스크롤 가능 여부 설정용 매개변수

  MissedEventList({this.isScrollable = true}); // 기본값은 스크롤 가능

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final lateSchedules = DbScheduleController.to.lateSchedules;

      if (lateSchedules.isEmpty) {
        return const SizedBox(height: 1,);
      }

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          physics: isScrollable
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: lateSchedules.map((schedule) {
            final color = Color(schedule.color ?? 0xFFCCCCCC);

            return ScheduleTile(
              title: schedule.title,
              startTime: schedule.startTime,
              endUsed: schedule.endUsed,
              endTime: schedule.endTime,
              color: color,
              lateCommet: DbCompleteScheduleController.to.getLateCommentByScheduledId(schedule.id),
            );
          }).toList(),
        ),
      );
    });
  }

}