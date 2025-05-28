import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:re_live/controller/db_journal_controller.dart';
import 'package:re_live/screen/home_screen.dart';

import 'package:intl/date_symbol_data_local.dart';  // 로케일 데이터 초기화용
import 'package:re_live/services/database_service.dart';
import 'controller/db_complete_schedule_controller.dart';
import 'controller/db_upcoming_schedule_controller.dart';
import 'controller/notification_controller.dart';
import 'controller/select_schedule_controller.dart';
import 'notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 한국어 로케일 초기화
  await initializeDateFormatting('ko_KR', null);
  await initNotification();
  Get.put(DatabaseService());
  Get.put(SelectScheduleController());
  Get.put(DbUpcomingScheduleController());
  Get.put(DbCompleteScheduleController());
  Get.put(DbJournalController());
  Get.put(NotificationController());



  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        fontFamily: 'BMJUA',
      ),
      home: HomeScreen(),
    ),
  );
}