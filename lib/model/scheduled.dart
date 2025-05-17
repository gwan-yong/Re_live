import 'package:drift/drift.dart';

class Scheduled extends Table {
  IntColumn get id => integer().autoIncrement()(); // primary key, 정수열
  TextColumn get title => text()();
  IntColumn get color => integer().nullable()();
  DateTimeColumn get date => dateTime()();
  IntColumn get  startTime => integer()();
  BoolColumn get endUsed => boolean()();
  IntColumn get endTime => integer()();
  TextColumn get repeatType => text().withDefault(const Constant('none'))();
  BoolColumn get repeatEndUsed => boolean()();
  DateTimeColumn get repeatEndDate => dateTime()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
}