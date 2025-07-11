import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_live/controller/db_journal_controller.dart';
import 'package:re_live/controller/db_upcoming_schedule_controller.dart';
import 'package:re_live/widget/common/rotating_dial.dart';

import '../../controller/select_schedule_controller.dart';

class DateCircularDial extends StatefulWidget {
  final VoidCallback? onCenterTap;

  const DateCircularDial({Key? key, this.onCenterTap}) : super(key: key);

  @override
  State<DateCircularDial> createState() => _DateCircularDialState();
}

class _DateCircularDialState extends State<DateCircularDial> {
  final ScrollController _scrollController = ScrollController();
  late double screenWidth;
  final double cardWidth = 5;
  int? lastCenterIndex;

  double get leftPadding => screenWidth / 2;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;

  }

  int getCenterIndex() {
    if (!_scrollController.hasClients) return 0;
    double scrollOffset = _scrollController.offset;
    double itemSpacing = 12.5;
    int centerIndex = (scrollOffset / itemSpacing).floor();
    return centerIndex;
  }

  double getYOffsetForIndex(int index, int centerIndex) {
    double radius = 200.0;
    double angle = (index - centerIndex) * pi / 60;
    double yOffset = radius - radius * cos(angle);
    if (index == centerIndex) yOffset -= 20;
    return yOffset;
  }
  void scrollToSelectedDate(List<DateTime> allDates) {
    final selectedDate = SelectScheduleController.to.selectDate.value;

    // 날짜와 일치하는 인덱스를 찾음 (날짜만 비교)
    final index = allDates.indexWhere((date) =>
    date.year == selectedDate.year &&
        date.month == selectedDate.month &&
        date.day == selectedDate.day);

    if (index != -1) {
      double itemSpacing = 12.5; // 카드 간 간격
      double targetOffset = itemSpacing * index;

      _scrollController.animateTo(
        targetOffset,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );

      //print('📍 선택된 날짜($selectedDate)에 해당하는 인덱스로 스크롤됨: $index');
    } else {
      print('⚠️ 선택된 날짜가 리스트에 없음: $selectedDate');
    }
  }

  void fun1 (){
    widget.onCenterTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final journalDates =
          DbJournalController.to.journalDates.whereType<DateTime>().toList();
      final scheduleDates =
          DbUpcomingScheduleController.to.UpcomingSchedulesDates
              .whereType<DateTime>()
              .toList();

      // 조건에 따라 날짜 결합
      final allDates = [
        if (journalDates.isNotEmpty) ...journalDates,
        if (scheduleDates.isNotEmpty) ...scheduleDates,
      ];

      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToSelectedDate(allDates);
      });

      // 둘 다 비어 있으면 아무것도 출력하지 않음
      if (allDates.isEmpty) {
        return  Container(
          height: 300,
            width: 400,
        );
      }

      return Column(
        children: [
          NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              final index = getCenterIndex();


              final journalDates =
                  DbJournalController.to.journalDates
                      .whereType<DateTime>()
                      .toList();
              final scheduleDates =
                  DbUpcomingScheduleController.to.UpcomingSchedulesDates
                      .whereType<DateTime>()
                      .toList();

              if (index < journalDates.length) {
                SelectScheduleController.to.selectDate.value =
                    journalDates[index];

              } else if (index - journalDates.length < scheduleDates.length) {
                SelectScheduleController.to.selectDate.value =
                    scheduleDates[index - journalDates.length];
              } else {
                print('⚠️ Index out of bounds');
              }

              return false;
            },
            child: AnimatedBuilder(
              animation: _scrollController,
              builder: (context, child) {
                int centerIndex = getCenterIndex();

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  physics: _SlowScrollPhysics(
                    speedFactor: 0.5,
                    parent: ClampingScrollPhysics(),
                  ),
                  padding:
                      allDates.length == 1
                          ? EdgeInsets.only(left: 0)
                          : EdgeInsets.symmetric(horizontal: leftPadding),
                  clipBehavior: Clip.none,
                  child: Row(
                    children: List.generate(allDates.length, (index) {
                      double xOffset = -index * 0.5;
                      double yOffset = getYOffsetForIndex(index, centerIndex);
                      double angle = (index - centerIndex) * pi / 60;



                      // index 기준으로 분기
                      bool isJournalDate = index < journalDates.length;

                      return TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: yOffset),
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOutBack,
                        builder: (context, animatedYOffset, child) {
                          return TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: angle),
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeOutBack,
                            builder: (context, animatedAngle, child) {
                              return Transform.translate(
                                offset: Offset(xOffset, animatedYOffset),
                                child: Transform.rotate(
                                  angle: animatedAngle,
                                  child: child,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                              ),
                              child: Card(
                                elevation: 0,
                                color:
                                    isJournalDate
                                        ? Colors.yellow.shade700
                                        : Colors.blue.shade300,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Container(
                                  height: 50,
                                  width: cardWidth,
                                  padding: const EdgeInsets.all(12),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 100,
              width: screenWidth,
              child: Stack(
                children: [
                  Positioned(
                    left: leftPadding-17,
                    child: Text(
                      '${SelectScheduleController.to.selectDate.value.month.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: leftPadding-27,
                    child: Text(
                      '${SelectScheduleController.to.selectDate.value.day.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
          RotatingDial(
            size: 100,
            onCenterTap: fun1,
          ),
        ],
      );
    });
  }
}


class _SlowScrollPhysics extends ClampingScrollPhysics {
  final double speedFactor;

  const _SlowScrollPhysics({this.speedFactor =0.3, ScrollPhysics? parent})
    : super(parent: parent);

  @override
  _SlowScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SlowScrollPhysics(
      speedFactor: speedFactor,
      parent: buildParent(ancestor),
    );
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    return super.applyPhysicsToUserOffset(position, offset * speedFactor);
  }
}
