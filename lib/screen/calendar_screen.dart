import 'package:flutter/material.dart';
import 'package:re_live/widget/main_calendar.dart';
import '../widget/scheduled_event_list.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key ? key}) : super(key: key);

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
            Expanded(child: ScheduledEventList(isScrollable: true)),
          ],
        ),
      )
    );
  }
}
