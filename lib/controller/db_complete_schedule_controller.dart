import 'package:get/get.dart';
import 'package:re_live/controller/select_schedule_controller.dart';
import 'package:re_live/services/database_service.dart';
import '../database/drift_database.dart';
import 'db_upcoming_schedule_controller.dart';

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
    completeSchedules.value = await db.getTodayCompeteScheduled(date);
  }

  Future<void> addCompleteSchedule(CompletedScheduledCompanion schedule) async {
    final db = DatabaseService.to.db;
    await db.insertCompleteSchedule(schedule);
    await loadCompleteSchedules(schedule.takenAt.value!);
    await DbUpcomingScheduleController.to.loadNowSchedules();
    await DbUpcomingScheduleController.to.loadLateSchedules();
  }

  Future<Map<DateTime, String>> getRandomRearImages() async {
    final db = DatabaseService.to.db;
    return await db.getRandomRearImagesByDate();
  }

  String? getLateCommentByScheduledId(int scheduledId) {
    try {
      return completeSchedules
          .firstWhere((e) => e.scheduledId == scheduledId)
          .lateComment;
    } catch (e) {
      return null; // 못 찾으면 null 반환
    }
  }
}