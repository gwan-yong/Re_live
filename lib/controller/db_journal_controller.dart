import 'package:get/get.dart';
import 'package:re_live/controller/select_schedule_controller.dart';
import '../database/drift_database.dart';
import '../services/database_service.dart';

class DbJournalController extends GetxController {
  static DbJournalController get to => Get.find();
  Rxn<JournalData> journal = Rxn<JournalData>();
  RxList<DateTime?> journalDates = <DateTime?>[].obs;
  Rx<DateTime> get selectDate => SelectScheduleController.to.selectDate;

  @override
  void onInit() {
    super.onInit();
    // 날짜가 바뀔 때마다 자동으로 일정 로딩
    ever(SelectScheduleController.to.selectDate, (_) {
      searchJournal(selectDate.value);
      loadJournalDates();
      print("일기 날짜 변경");
    });
    // 초기 로딩
    searchJournal(selectDate.value);
    loadJournalDates();
  }


  Future<void> searchJournal(DateTime date) async {
    final db = DatabaseService.to.db;
    journal.value = await db.searchJournal(date);
    print("$date 일자의 일기 조회");
  }

  Future<void> addJournal(JournalCompanion value) async {
    final db = DatabaseService.to.db;
    await db.insertJournal(value);
    await loadJournalDates();
    print('journalDates 생성됨 : $journalDates');
  }

  Future<void> loadJournalDates() async {
    final db = DatabaseService.to.db;
    final rawDates = await db.getDistinctJournalDates();

    // null 제거 후 DateTime만 필터링
    final dates = rawDates.whereType<DateTime>().toList();

    dates.sort((a, b) => a.compareTo(b));

    journalDates.assignAll(dates);
    print('모든 journalDates : $journalDates');
  }

  Future<void> updateJourna (DateTime date, JournalCompanion value ) async{
    final db = DatabaseService.to.db;
    await db.updateJournalByDate(date,value);
    await loadJournalDates();
    await searchJournal(selectDate.value);
  }

}