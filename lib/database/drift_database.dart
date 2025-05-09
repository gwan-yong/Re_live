import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:re_live/model/scheduled.dart';


part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Scheduled,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  // 싱글턴 인스턴스를 위한 정적 변수
  static final LocalDatabase _instance = LocalDatabase._internal();

  // 팩토리 생성자
  factory LocalDatabase() {
    return _instance;
  }

  // 내부 생성자
  LocalDatabase._internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> insertSchedule(ScheduledCompanion schedule) {
    return into(scheduled).insert(schedule);
  }//데이터 입력

  /*Future<List<ScheduledData>> getTodaySchedules() async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day); // 오늘 00:00:00
    final tomorrowStart = todayStart.add(Duration(days: 1));   // 내일 00:00:00

    final schedules = await (select(scheduled)
      ..where((tbl) => tbl.date.isBetweenValues(todayStart, tomorrowStart)))
        .get();

    // 시간 순으로 정렬
    schedules.sort((a, b) => a.startTime.compareTo(b.startTime));

    return schedules;
  } // 오늘 데이터만 출력*/
  Future<List<ScheduledData>> getSchedulesByDate(DateTime selectedDate) async {
    final startOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day); // 선택한 날짜의 00:00:00
    final endOfDay = startOfDay.add(Duration(days: 1)); // 선택한 날짜의 23:59:59

    final schedules = await (select(scheduled)
      ..where((tbl) => tbl.date.isBetweenValues(startOfDay, endOfDay)))
        .get();

    // 시간 순으로 정렬
    schedules.sort((a, b) => a.startTime.compareTo(b.startTime));

    return schedules;
  }


  Future<List<ScheduledData>> getAllSchedules() {
    return select(scheduled).get();
  }//모든 데이터 출력

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}