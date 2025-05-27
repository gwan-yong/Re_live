import 'package:flutter/material.dart';
import 'package:re_live/widget/main_calendar.dart';
import '../controller/select_schedule_controller.dart';
import '../database/drift_database.dart';
import '../widget/scheduled_event_list.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  @override
  void dispose() {
    // 화면이 사라질 때 초기화 실행
    SelectScheduleController.to.reset();
    super.dispose();
  }

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
            MainCalendar(),
            Expanded(
              child: ScheduledEventList(
                isScrollable: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
