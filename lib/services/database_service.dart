import 'package:get/get.dart';
import '../database/drift_database.dart';

class DatabaseService extends GetxService {
  static DatabaseService get to => Get.find();
  late final LocalDatabase _db;

  @override
  void onInit() {
    _db = LocalDatabase();
    super.onInit();
  }

  LocalDatabase get db => _db;
}