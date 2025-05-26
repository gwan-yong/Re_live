import 'package:get/get.dart';
import 'package:re_live/controller/select_schedule_controller.dart';
import 'package:re_live/services/database_service.dart';
import '../database/drift_database.dart';

class DbScheduleController extends GetxController {
  static DbScheduleController get to => Get.find();

  var schedules = <ScheduledData>[].obs;
  var selectDate = SelectScheduleController.to.selectDate.value;

  Future<void> loadSchedules() async {
    final db = DatabaseService.to.db;
    schedules.value = await db.getSchedulesByDate(selectDate);
  }

  Future<void> addSchedule(ScheduledCompanion schedule) async {
    final db = DatabaseService.to.db;
    await db.insertSchedule(schedule);
    await loadSchedules();
  }

  Future<void> deleteSchedule(int id) async {
    final db = DatabaseService.to.db;
    await db.deleteSchedule(id);
  }

  Future<ScheduledData?> getCurrentRunning() async {
    final db = DatabaseService.to.db;
    return await db.getCurrentRunningSchedule();
  }
}