import 'package:flutter/material.dart';
import 'package:re_live/screen/home_screen.dart';

import 'package:intl/date_symbol_data_local.dart';  // 로케일 데이터 초기화용
import 'package:re_live/screen/missed_event_journal.dart';
import 'notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 한국어 로케일 초기화
  await initializeDateFormatting('ko_KR', null);
  await initNotification();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        fontFamily: 'BMJUA',
      ),
      home: HomeScreen(),
      /*MissedEventJournal(
          scheduledId: 1,
          title: '운동하기',
          startTime: '오후 7시',
          endUsed: false,
          endTime: '컨디션 안 좋음',
          color:Colors.red
      ),*/
    ),
  );
}