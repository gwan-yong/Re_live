import 'dart:io';
import 'dart:math';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:re_live/model/scheduled.dart';
import '../model/completed_scheduled.dart';
import '../model/journal.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [Scheduled, CompletedScheduled, Journal])
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

  //일정 입력
  Future<int> insertSchedule(ScheduledCompanion schedule) {
    return into(scheduled).insert(schedule);
  }

  //해당 일정 삭제
  Future<int> deleteSchedule(int scheduleId) {
    return (delete(scheduled)..where((tbl) => tbl.id.equals(scheduleId))).go();
  }

  //모든 scheduled 데이터 출력
  Future<List<ScheduledData>> getAllSchedules() {
    return select(scheduled).get();
  }

  //해당 날짜에 실행 예정인 일정 출력
  Future<List<ScheduledData>> getSchedulesByDate(DateTime targetDate) async {
    final allSchedules = await select(scheduled).get();
    final completed = await select(completedScheduled).get();

    // targetDate를 기준으로 연, 월, 일만 비교하도록 normalization
    final normalizedTargetDate = DateTime(targetDate.year, targetDate.month, targetDate.day);

    // completedSchedule 중 이미 완료된 scheduleId 목록 수집
    final completedOnTargetDate = completed.where((c) {
      final taken = DateTime(c.takenAt.year, c.takenAt.month, c.takenAt.day);
      return taken == normalizedTargetDate;
    }).map((c) => c.scheduledId).whereType<int>().toSet();

    return allSchedules.where((s) {
      final startDate = DateTime(s.date.year, s.date.month, s.date.day);
      final isAfterStart = !normalizedTargetDate.isBefore(startDate);

      // 반복 종료 조건 체크
      if (s.repeatEndUsed &&
          s.repeatEndDate != null &&
          normalizedTargetDate.isAfter(DateTime(s.repeatEndDate!.year, s.repeatEndDate!.month, s.repeatEndDate!.day))) {
        return false;
      }

      // 이미 완료된 항목은 제외
      if (completedOnTargetDate.contains(s.id)) return false;

      switch (s.repeatType) {
        case '없음':
          return startDate == normalizedTargetDate;

        case '매일':
          return isAfterStart;

        case '매주':
          return isAfterStart && startDate.weekday == normalizedTargetDate.weekday;

        case '매월':
          return isAfterStart && startDate.day == normalizedTargetDate.day;

        case '매년':
          return isAfterStart &&
              startDate.month == normalizedTargetDate.month &&
              startDate.day == normalizedTargetDate.day;

        default:
          return false;
      }
    }).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  //현재 진행중인 일정 가져오기
  Future<ScheduledData?> getCurrentRunningSchedule() async {
    final now = DateTime.now();
    final nowMinutes = now.hour * 60 + now.minute;

    // 오늘 날짜 기준 일정 가져오기
    final schedules = await getSchedulesByDate(now);

    for (final schedule in schedules) {
      final start = schedule.startTime;
      final endUsed = schedule.endUsed;
      final end = schedule.endTime;

      // 종료 시간 사용 여부에 따라 조건 분기
      if (!endUsed) {
        // 시작 시간부터 30분 이내인지 확인
        if (start <= nowMinutes && nowMinutes <= start + 30) {
          return schedule;
        }
      } else if (end != null) {
        // 시작 시간과 종료 시간 사이인지 확인
        if (start <= nowMinutes && nowMinutes < end) {
          return schedule;
        }
      }
    }

    return null; // 조건을 만족하는 일정이 없으면 null
  }


  //일정 수정
  Future<void> updateSchedule(int id, ScheduledCompanion newValues) async {
    await (update(scheduled)..where((tbl) => tbl.id.equals(id)))
        .write(newValues);
  }

  //등록하지 못한 일정 가져오기
  Future<List<ScheduledData>> getTodayLateSchedules() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day); // 오늘 00:00
    final startOfNextDay = startOfDay.add(Duration(days: 1));         // 내일 00:00

    final query = select(scheduled).join([
      innerJoin(
        completedScheduled,
        completedScheduled.scheduledId.equalsExp(scheduled.id),
        useColumns: false,
      )
    ])
      ..where(completedScheduled.takenAt.isBetweenValues(startOfDay, startOfNextDay))
      ..where(completedScheduled.lateComment.isNotNull());

    final result = await query.get();
    return result.map((row) => row.readTable(scheduled)).toList();
  }


  //완료 일정 등록하기
  Future<int> insertCompleteSchedule(CompletedScheduledCompanion schedule ) {
    return into(completedScheduled).insert(schedule);
  }

  //완료된 일정 모두 보여주기
  Future<List<CompletedScheduledData>> getAllCompletePhotos() {
    return select(completedScheduled).get();
  }

  //해당 날짜에 완료된 일정들 출력하기
  Future<List<CompletedScheduledData>> getTodayCompeteScheduled(DateTime date) async {
    final selectDay = DateTime(date.year, date.month, date.day); // 선택 날짜 00:00
    final selectDayTomorrow = selectDay.add(
      Duration(days: 1),
    ); // 선택 날짜 다음날 00:00

    return await (select(completedScheduled)
      ..where(
            (tbl) => tbl.takenAt.isBetweenValues(selectDay, selectDayTomorrow),
      )
      ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.takenAt), // 오름차순 정렬
      ]))
        .get();
  }

  //달력 날짜에 표시할 이미지를 해당 일자에 촬영된 사진 중 랜덤하게 선택하기
  Future<Map<DateTime, String>> getRandomRearImagesByDate() async {
    final allPhotos = await select(completedScheduled).get();

    // 날짜별로 묶기 (rearImgPath가 null이 아닌 것만 포함)
    final Map<DateTime, List<CompletedScheduledData>> photosByDate = {};

    for (final photo in allPhotos) {
      if (photo.rearImgPath == null) continue; // null이면 건너뜀

      final dateOnly = DateTime(
        photo.takenAt.year,
        photo.takenAt.month,
        photo.takenAt.day,
      );

      photosByDate.putIfAbsent(dateOnly, () => []);
      photosByDate[dateOnly]!.add(photo);
    }

    // 각 날짜에서 랜덤한 rearImgPath 선택
    final Map<DateTime, String> result = {};
    final random = Random();

    photosByDate.forEach((date, photoList) {
      if (photoList.isNotEmpty) {
        final randomPhoto = photoList[random.nextInt(photoList.length)];
        result[date] = randomPhoto.rearImgPath!;
      }
    });

    return result;
  }

  //일기 등록
  Future<int> insertJournal(JournalCompanion value) {
    return into(journal).insert(value);
  }

  Future<JournalData?> searchJournal(DateTime targetDate) {
    final start = DateTime(targetDate.year, targetDate.month, targetDate.day);
    final end = start.add(const Duration(days: 1));

    return (select(journal)
      ..where((j) => j.date.isBetweenValues(start, end)))
        .getSingleOrNull();
  }

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
