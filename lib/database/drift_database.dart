import 'dart:io';
import 'dart:math';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:re_live/model/scheduled.dart';
import '../model/completed_photos.dart';

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Scheduled,
    CompletedPhotos,
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

  Future<List<ScheduledData>> getSchedulesByDate(DateTime selectedDate) async {
    final selectedDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day); // 00:00:00

    final schedules = await (select(scheduled)
      ..where((tbl) =>
      tbl.date.equals(selectedDay) & // 날짜 일치
      tbl.completed.equals(false)   // 완료되지 않은 일정만
      ))
        .get();

    schedules.sort((a, b) => a.startTime.compareTo(b.startTime));
    return schedules;
  }

  Future<int> deleteSchedule(int scheduleId) {
    return (delete(scheduled)..where((tbl) => tbl.id.equals(scheduleId))).go();
  }

  Future<List<ScheduledData>> getAllSchedules() {
    return select(scheduled).get();
  }//모든 scheduled 데이터 출력

  Future<int> markScheduleAsCompleted(int scheduledId) {
    return (update(scheduled)..where((tbl) => tbl.id.equals(scheduledId))).write(
      ScheduledCompanion(completed: Value(true)),
    );
  }

  Future<int> markScheduleAsMissed(int scheduledId) {
    return (update(scheduled)..where((tbl) => tbl.id.equals(scheduledId))).write(
      ScheduledCompanion(missed: Value(true)),
    );
  }

  Future<int> insertCompletePhoto(CompletedPhotosCompanion photo) {
    return into(completedPhotos).insert(photo);
  }

  Future<List<CompletedPhoto>> getAllCompletePhotos() {
    return select(completedPhotos).get();
  }//모든 completePhotos 데이터 출력

  Future<List<CompletedPhoto>> getTodayPhotos(DateTime date) async {
    final now = date;
    final todayStart = DateTime(now.year, now.month, now.day); // 오늘 00:00
    final tomorrowStart = todayStart.add(Duration(days: 1));   // 내일 00:00

    return await (select(completedPhotos)
      ..where((tbl) => tbl.takenAt.isBetweenValues(todayStart, tomorrowStart))
      ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.takenAt) // 오름차순 정렬
      ])
    ).get();
  }

  Future<Map<DateTime, String>> getRandomRearImagesByDate() async {
    final allPhotos = await select(completedPhotos).get();

    // 날짜별로 묶기
    final Map<DateTime, List<CompletedPhoto>> photosByDate = {};

    for (final photo in allPhotos) {
      // takenAt의 날짜(시간 제외)만 추출
      final dateOnly = DateTime(photo.takenAt.year, photo.takenAt.month, photo.takenAt.day);

      if (!photosByDate.containsKey(dateOnly)) {
        photosByDate[dateOnly] = [];
      }
      photosByDate[dateOnly]!.add(photo);
    }

    // 각 날짜에서 랜덤한 rearImgPath 선택
    final Map<DateTime, String> result = {};
    final random = Random();

    photosByDate.forEach((date, photoList) {
      final randomPhoto = photoList[random.nextInt(photoList.length)];
      result[date] = randomPhoto.rearImgPath;
    });
    return result;
  }

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}