import 'package:get/get.dart';
import 'package:re_live/controller/select_schedule_controller.dart';
import 'package:re_live/services/database_service.dart';
import '../database/drift_database.dart';
import 'notification_controller.dart';

class DbScheduleController extends GetxController {
  static DbScheduleController get to => Get.find();

  var schedules = <ScheduledData>[].obs;
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
  }

  Future<void> loadSchedules() async {
    final db = DatabaseService.to.db;
    schedules.value = await db.getSchedulesByDate(selectDate.value);
  }

  Future<void> addSchedule(ScheduledCompanion schedule) async {
    final db = DatabaseService.to.db;
    await db.insertSchedule(schedule);
    await loadSchedules();
    await NotificationController.to.refresh();
  }

  Future<void> deleteSchedule(int id) async {
    final db = DatabaseService.to.db;
    await db.deleteSchedule(id);
    await NotificationController.to.refresh();
  }

  Future<ScheduledData?> getCurrentRunning() async {
    final db = DatabaseService.to.db;
    return await db.getCurrentRunningSchedule();
  }
}