import 'package:drift/drift.dart';

class Scheduled extends Table {
  IntColumn get id => integer().autoIncrement()(); // primary key, 정수열
  TextColumn get title => text()();
  IntColumn get color => integer().nullable()();
  DateTimeColumn get date => dateTime()();
  IntColumn get  startTime => integer()();
  BoolColumn get endUsed => boolean()();
  IntColumn get endTime => integer().nullable()();
  TextColumn get repeatType => text().withDefault(const Constant('없음'))();
  BoolColumn get repeatEndUsed => boolean().withDefault(Constant(false))();
  DateTimeColumn get repeatEndDate => dateTime().nullable()();
}