import 'package:drift/drift.dart';

class CompletedScheduled extends Table {
  IntColumn get id => integer().autoIncrement()(); // primary key
  IntColumn get scheduledId =>
      integer().nullable().customConstraint('REFERENCES scheduled(id)')();
  TextColumn get frontImgPath => text().nullable()();
  TextColumn get rearImgPath => text().nullable()();
  TextColumn get lateComment => text().nullable()();
  DateTimeColumn get takenAt => dateTime()();
  BoolColumn get notDisplay=> boolean().withDefault(Constant(false))();
}

