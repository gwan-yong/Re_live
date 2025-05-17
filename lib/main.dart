import 'package:flutter/material.dart';
import 'package:re_live/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';  // 로케일 데이터 초기화용

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 한국어 로케일 초기화
  await initializeDateFormatting('ko_KR', null);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'BMJUA',
      ),
      home: HomeScreen(),
    ),
  );
}