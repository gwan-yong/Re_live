import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:re_live/screen/bottom_area.dart';
import 'package:re_live/widget/schedule/card_circular_carousel.dart';
import '../controller/card_carousel_controller.dart';
import '../controller/select_schedule_controller.dart';
import '../database/drift_database.dart';
import '../widget/fab_menu_button.dart';



class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalDatabase database = LocalDatabase();
  final DateTime selectedDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            top: true,
            bottom: false,
            child: Container(
              margin: EdgeInsets.all(0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _title(),
                    Obx(() {
                      final selectedDate = SelectScheduleController.to.selectDate.value;
                      return CardCircularCarousel(
                        key: ValueKey(selectedDate),
                        scale: CardCarouselController.to.cardCarouselScale.value,
                      );
                    }),
                    BottomArea(
                      onCalendarOpened: () {
                        setState(() {
                          CardCarouselController.to.setScale (0.7);
                        });
                      },
                      onCalendarClosed: () {
                        setState(() {
                          CardCarouselController.to.setScale (1.0);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          //FAButtonMenu(),
        ],
      ),
    );
  }


  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              // 로그 출력 코드 생략 가능
            },
            child: Text(
              'ReLive',
              style: TextStyle(fontSize: 50.0),
            ),
          ),
        ],
      ),
    );
  }
}