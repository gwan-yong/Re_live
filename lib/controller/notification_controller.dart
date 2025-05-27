import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

import '../database/drift_database.dart';
import '../notification.dart';
import '../services/database_service.dart';

class NotificationController extends GetxController {
  static NotificationController get to => Get.find();

  var schedules = <ScheduledData>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTodaySchedules(); // 앱 실행 시 자동 호출
  }

  /// 오늘 날짜의 일정들을 가져오고 알림 등록
  Future<void> loadTodaySchedules() async {
    final today = DateTime.now();
    final db = DatabaseService.to.db;
    final dbSchedules = await db.getSchedulesByDate(today);

    // 알림 등록 전 기존 알림 제거
    await _cancelAllTodayNotifications();

    schedules.value = dbSchedules;

    for (final schedule in schedules) {
      // 시작 알림
      final scheduledStart = DateTime(
        today.year,
        today.month,
        today.day,
        schedule.startTime ~/ 60,
        schedule.startTime % 60,
      );

      if (scheduledStart.isAfter(DateTime.now())) {
        showScheduledNotification(schedule.id, scheduledStart, schedule.title);
      }

      // 놓친 일정 알림
      DateTime? scheduledEnd;
      if (schedule.endUsed && schedule.endTime != null) {
        scheduledEnd = DateTime(
          today.year,
          today.month,
          today.day,
          schedule.endTime! ~/ 60,
          schedule.endTime! % 60,
        );
      }

      final startTimeStr = _formatTime(schedule.startTime);
      final endTimeStr = _formatTime(schedule.endTime);
      final color = schedule.color ?? 0;

      if (!schedule.endUsed) {
        showMissedScheduleNotification(
          schedule.id,
          schedule.title,
          scheduledStart.add(Duration(minutes: 1)), //몇분 뒤 알림 발생
          startTimeStr,
          schedule.endUsed,
          endTimeStr,
          color,
        );
      } else if (scheduledEnd != null) {
        showMissedScheduleNotification(
          schedule.id,
          schedule.title,
          scheduledEnd,
          startTimeStr,
          schedule.endUsed,
          endTimeStr,
          color,
        );
      }
    }
  }

  /// 일정이 추가/삭제되면 수동으로 다시 호출
  Future<void> refresh() async {
    await loadTodaySchedules();
  }

  /// 오늘 날짜 기준 기존 알림 제거
  Future<void> _cancelAllTodayNotifications() async {
    final pending = await notifications.pendingNotificationRequests();

    final today = DateTime.now();
    final todayIds = schedules.map((e) => e.id).toSet();
    final missedIds = todayIds.map((id) => 10000 + id).toSet();

    for (final p in pending) {
      if (todayIds.contains(p.id) || missedIds.contains(p.id)) {
        await notifications.cancel(p.id);
      }
    }
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
}
