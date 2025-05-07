import 'package:flutter/material.dart';
import 'package:re_live/widget/main_calendar.dart';
import '../database/drift_database.dart';
import '../widget/scheduled_event_list.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final LocalDatabase database = LocalDatabase();
  DateTime selectedDate = DateTime.now(); // 선택된 날짜 상태 관리

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text('달력'),
      ),
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            // MainCalendar에 onDateSelected 콜백 전달
            MainCalendar(
              onDateSelected: (DateTime newDate) {
                setState(() {
                  selectedDate = newDate; // 선택된 날짜 갱신
                });
              },
            ),
            // 선택된 날짜를 전달하여 이벤트 목록을 표시
            Expanded(
              child: ScheduledEventList(
                isScrollable: true,
                database: database,
                selectedDate: selectedDate, // 선택된 날짜 전달
              ),
            ),
          ],
        ),
      ),
    );
  }
}