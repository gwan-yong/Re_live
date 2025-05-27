import 'package:get/get.dart';
import 'package:re_live/controller/select_schedule_controller.dart';
import 'package:re_live/services/database_service.dart';
import '../database/drift_database.dart';

class DbCompleteScheduleController extends GetxController {
  static DbCompleteScheduleController get to => Get.find();
  var completeSchedules = <CompletedScheduledData>[].obs;

  Rx<DateTime> get selectDate => SelectScheduleController.to.selectDate;

  @override
  void onInit() {
    super.onInit();

    // 날짜가 바뀔 때마다 자동으로 일정 로딩
    ever(selectDate, (_) {
      loadCompleteSchedules(selectDate.value);
    });

    // 초기 로딩
    loadCompleteSchedules(selectDate.value);
  }

  Future<void> loadCompleteSchedules(DateTime date) async {
    final db = DatabaseService.to.db;
    completeSchedules.value = await db.getTodayPhotos(date);
  }

  Future<void> addCompleteSchedule(CompletedScheduledCompanion schedule) async {
    final db = DatabaseService.to.db;
    await db.insertCompleteSchedule(schedule);
    await loadCompleteSchedules(schedule.takenAt.value!);
  }

  Future<Map<DateTime, String>> getRandomRearImages() async {
    final db = DatabaseService.to.db;
    return await db.getRandomRearImagesByDate();
  }
}