import 'package:drift/drift.dart';

class CompletedScheduled extends Table {
  IntColumn get id => integer().autoIncrement()(); // primary key
  IntColumn get scheduledId => integer().customConstraint('REFERENCES scheduled(id)')();
  TextColumn get frontImgPath => text()();
  TextColumn get rearImgPath => text()();
  DateTimeColumn get takenAt => dateTime()();
}

