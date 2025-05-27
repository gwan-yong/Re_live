import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/db_schedule_controller.dart';
import '../controller/notification_controller.dart';
import '../controller/select_schedule_controller.dart';
import '../notification.dart';

/*
class ScheduledEventList extends StatelessWidget {
  final bool isScrollable;
  final DateTime selectedDate = SelectScheduleController.to.selectDate.value;

  ScheduledEventList({this.isScrollable = true}) {
    // 초기 로딩
    DbScheduleController.to.loadSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final schedules = DbScheduleController.to.schedules;

      if (schedules.isEmpty) {
        return Center(child: Text('등록된 일정이 없습니다.'));
      }

      final DateTime now = DateTime.now();

      for (final schedule in schedules) {
        final scheduledStart = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          schedule.startTime ~/ 60,
          schedule.startTime % 60,
        );

        DateTime? scheduledEnd;
        if (schedule.endUsed && schedule.endTime != null) {
          scheduledEnd = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            schedule.endTime! ~/ 60,
            schedule.endTime! % 60,
          );
        }

        if (scheduledStart.isAfter(now)) {
          showScheduledNotification(
            schedule.id,
            scheduledStart,
            schedule.title,
          );
        }

        // 놓친 일정 알림
        if (!schedule.endUsed) {
          showMissedScheduleNotification(
            schedule.id,
            schedule.title,
            scheduledStart.add(Duration(minutes: 1)),
            _formatTime(schedule.startTime),
            schedule.endUsed,
            _formatTime(schedule.endTime),
            schedule.color ?? 0,
          );
        } else if (scheduledEnd != null) {
          showMissedScheduleNotification(
            schedule.id,
            schedule.title,
            scheduledEnd,
            _formatTime(schedule.startTime),
            schedule.endUsed,
            _formatTime(schedule.endTime),
            schedule.color ?? 0,
          );
        }
      }

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          physics: isScrollable
              ? AlwaysScrollableScrollPhysics()
              : NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: schedules.map((schedule) {
            final startTime = _formatTime(schedule.startTime);
            final endTime = _formatTime(schedule.endTime);
            final color = Color(schedule.color ?? 0xFFCCCCCC);

            return _EventTile(
              schedule.title,
              startTime,
              schedule.endUsed,
              endTime,
              color,
            );
          }).toList(),
        ),
      );
    });
  }

  String _formatTime(int? rawTime) {
    if (rawTime == null) return '-';

    final hour = rawTime ~/ 60;
    final minute = rawTime % 60;
    final time = TimeOfDay(hour: hour, minute: minute);
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm('ko').format(dt);
  }

  Widget _EventTile(
      String title,
      String startTime,
      bool endUsed,
      String endTime,
      Color color,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      height: 90,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 25)),
          Row(children: [Text(startTime), if (endUsed) Text(" ~ $endTime")]),
        ],
      ),
    );
  }
}*/
class ScheduledEventList extends StatelessWidget {
  final bool isScrollable;
  final DateTime selectedDate = SelectScheduleController.to.selectDate.value;

  ScheduledEventList({this.isScrollable = true}) {
    // 초기 로딩
    DbScheduleController.to.loadSchedules();
    // 선택된 날짜에 대한 알림 처리
    NotificationController.to.loadTodaySchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final schedules = DbScheduleController.to.schedules;

      if (schedules.isEmpty) {
        return Center(child: Text('등록된 일정이 없습니다.'));
      }

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          physics: isScrollable
              ? AlwaysScrollableScrollPhysics()
              : NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: schedules.map((schedule) {
            final startTime = _formatTime(schedule.startTime);
            final endTime = _formatTime(schedule.endTime);
            final color = Color(schedule.color ?? 0xFFCCCCCC);

            return _EventTile(
              schedule.title,
              startTime,
              schedule.endUsed,
              endTime,
              color,
            );
          }).toList(),
        ),
      );
    });
  }

  String _formatTime(int? rawTime) {
    if (rawTime == null) return '-';

    final hour = rawTime ~/ 60;
    final minute = rawTime % 60;
    final time = TimeOfDay(hour: hour, minute: minute);
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm('ko').format(dt);
  }

  Widget _EventTile(
      String title,
      String startTime,
      bool endUsed,
      String endTime,
      Color color,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      height: 90,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 25)),
          Row(children: [Text(startTime), if (endUsed) Text(" ~ $endTime")]),
        ],
      ),
    );
  }
}