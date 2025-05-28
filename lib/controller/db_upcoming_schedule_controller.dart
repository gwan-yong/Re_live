import 'package:get/get.dart';
import 'package:re_live/controller/select_schedule_controller.dart';
import 'package:re_live/services/database_service.dart';
import '../database/drift_database.dart';
import 'notification_controller.dart';

class DbUpcomingScheduleController extends GetxController {
  static DbUpcomingScheduleController get to => Get.find();

  var upcomingSchedules = <UpcomingScheduledData>[].obs;
  var lateSchedules = <UpcomingScheduledData>[].obs;
  Rx<DateTime> get selectDate => SelectScheduleController.to.selectDate;

  @override
  void onInit() {
    super.onInit();
    // 날짜가 바뀔 때마다 자동으로 일정 로딩
    ever(selectDate, (_) {
      loadSchedules();
    });

    // 초기 로딩
    loadSchedules();
    loadLateSchedules();
  }

  Future<void> loadSchedules() async {
    final db = DatabaseService.to.db;
    upcomingSchedules.value = await db.getSchedulesByDate(selectDate.value);
  }

  Future<void> addSchedule(UpcomingScheduledCompanion schedule) async {
    final db = DatabaseService.to.db;
    await db.insertSchedule(schedule);
    await loadSchedules();
    await NotificationController.to.refresh();
    print("${schedule.title} 일정이 추가됨");
  }

  Future<void> deleteSchedule(int id) async {
    final db = DatabaseService.to.db;
    await db.deleteSchedule(id);
    await NotificationController.to.refresh();
    print("일정 id ${id} 가 삭제됨");
  }

  Future<UpcomingScheduledData?> searchSchedule(int id) async {
    await loadSchedules();
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
    loadSchedules();
  }



}