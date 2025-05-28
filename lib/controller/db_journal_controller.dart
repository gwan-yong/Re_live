import 'package:get/get.dart';
import 'package:re_live/controller/select_schedule_controller.dart';
import '../database/drift_database.dart';
import '../services/database_service.dart';

class DbJournalController extends GetxController {
  static DbJournalController get to => Get.find();
  Rxn<JournalData> journal = Rxn<JournalData>();

  Rx<DateTime> get selectDate => SelectScheduleController.to.selectDate;

  @override
  void onInit() {
    super.onInit();
    // 날짜가 바뀔 때마다 자동으로 일정 로딩
    ever(selectDate, (_) {
      searchJournal(selectDate.value);
    });
    // 초기 로딩
    searchJournal(selectDate.value);
  }


  Future<void> searchJournal(DateTime date) async {
    final db = DatabaseService.to.db;
    journal.value = await db.searchJournal(date);
  }

  Future<void> addJournal(JournalCompanion value) async {
    final db = DatabaseService.to.db;
    await db.insertJournal(value);
  }

}