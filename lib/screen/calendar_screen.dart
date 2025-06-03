import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_live/widget/main_calendar.dart';
import 'package:re_live/widget/schedule/card_circular_carousel.dart';
import '../controller/select_schedule_controller.dart';
import '../widget/journal_widget.dart';
import '../widget/schedule/completed_scheduled_list_items.dart';
import '../widget/schedule/journal_card.dart';
import '../widget/schedule/upcoming_scheduled_list_items.dart';

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
              /*Obx(() {
                final selectedDate =
                    SelectScheduleController.to.selectDate.value;
                return
                  CardCircularCarousel(
                    key: ValueKey(selectedDate),
                scale: 0.7);
              }),*/
            ],
          ),
        ),
      );
  }
}
