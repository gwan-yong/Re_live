import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:re_live/controller/select_schedule_controller.dart';
import 'package:re_live/services/database_service.dart';
import '../database/drift_database.dart';
import '../widget/common/date_circular_dial.dart';
import 'db_journal_controller.dart';
import 'notification_controller.dart';

class DbUpcomingScheduleController extends GetxController {
  static DbUpcomingScheduleController get to => Get.find();

  var allUpcomingSchedules = <UpcomingScheduledData>[].obs;
  var upcomingSchedules = <UpcomingScheduledData>[].obs;
  var lateSchedules = <UpcomingScheduledData>[].obs;
  RxList<DateTime?> UpcomingSchedulesDates = <DateTime?>[].obs;
  Rx<DateTime> get selectDate => SelectScheduleController.to.selectDate;

  @override
  void onInit() {
    super.onInit();
    // 날짜가 바뀔 때마다 자동으로 일정 로딩
    ever(selectDate, (_) {
      loadNowSchedules();
      loadAllSchedules();
      loadSchedulesDates();
    });

    // 초기 로딩
    loadNowSchedules();
    loadLateSchedules();
    loadSchedulesDates();
    loadAllSchedules();
  }

  Future<void> loadNowSchedules() async {
    final db = DatabaseService.to.db;
    upcomingSchedules.value = await db.getSchedulesByDate(selectDate.value);
  }

  Future<void> loadAllSchedules() async {
    final db = DatabaseService.to.db;
    allUpcomingSchedules.value = await db.getAllSchedules();
  }


  Future<void> addSchedule(UpcomingScheduledCompanion schedule) async {
    final db = DatabaseService.to.db;
    await db.insertSchedule(schedule);
    await loadNowSchedules();
    await loadAllSchedules();
    await NotificationController.to.refresh();
    await loadSchedulesDates();
    print("${schedule.title} 일정이 추가됨");
  }

  Future<void> deleteSchedule(int id) async {
    final db = DatabaseService.to.db;
    await db.deleteSchedule(id);
    await NotificationController.to.refresh();
    await loadSchedulesDates();
    await DbJournalController.to.loadJournalDates();
    print("일정 id ${id} 가 삭제됨");
  }

  Future<UpcomingScheduledData?> searchSchedule(int id) async {
    await loadNowSchedules();
    try {
      return upcomingSchedules.firstWhere((schedule) => schedule.id == id);
    } catch (e) {
      // 해당 id를 가진 schedule이 없을 경우 null 반환
      return null;
    }
  }

  Future<UpcomingScheduledData?> getCurrentRunning() async {
    final db = DatabaseService.to.db;
    return await db.getCurrentRunningSchedule();
  }

  Future<void> loadLateSchedules() async {
    final db = DatabaseService.to.db;
    lateSchedules.value = await db.getTodayLateSchedules();
  }

  Future<void> updateSchedule(int id, UpcomingScheduledCompanion newValues) async {
    final db = DatabaseService.to.db;
    await db.updateSchedule(id, newValues);
    await loadNowSchedules();
    await loadSchedulesDates();
  }

  String? getScheduleTitleById(int id) {
    try {
      final schedule = allUpcomingSchedules.firstWhere((s) => s.id == id);
      return schedule.title;
    } catch (e) {
      return null;
    }
  }

  int? getScheduleColorById(int id) {
    try {
      final schedule = allUpcomingSchedules.firstWhere((s) => s.id == id);
      return schedule.color;
    } catch (e) {
      return null;
    }
  }

  Future<void> loadSchedulesDates() async {
    final db = DatabaseService.to.db;
    final rawDates = await db.getDatesWithSchedules();

    // null 제거 후 DateTime만 필터링
    final dates = rawDates.whereType<DateTime>().toList();

    dates.sort((a, b) => a.compareTo(b));

    UpcomingSchedulesDates.assignAll(dates);
    print('UpcomingSchedulesDates : $UpcomingSchedulesDates');
  }

}