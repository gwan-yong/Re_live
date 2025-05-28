import 'package:drift/drift.dart';

class Journal extends Table {
  DateTimeColumn get date => dateTime()();
  TextColumn get comment => text()();
}