import 'package:drift/drift.dart';

class CompletedPhotos extends Table {
  IntColumn get id => integer().autoIncrement()(); // primary key
  IntColumn get scheduledId =>
      integer().nullable().customConstraint('REFERENCES scheduled(id)')();
  TextColumn get frontImgPath => text()();
  TextColumn get rearImgPath => text()();
  DateTimeColumn get takenAt => dateTime()();
}

