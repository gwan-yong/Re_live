import 'package:get/get.dart';
import 'package:re_live/services/database_service.dart';
import '../database/drift_database.dart';

class DbPhotoController extends GetxController {
  final _db = Get.find<DatabaseService>().db;
  var todayPhotos = <CompletedPhoto>[].obs;

  Future<void> loadTodayPhotos(DateTime date) async {
    todayPhotos.value = await _db.getTodayPhotos(date);
  }

  Future<void> addPhoto(CompletedPhotosCompanion photo) async {
    await _db.insertCompletePhoto(photo);
    await loadTodayPhotos(photo.takenAt.value!);
  }

  Future<Map<DateTime, String>> getRandomRearImages() async {
    return await _db.getRandomRearImagesByDate();
  }
}