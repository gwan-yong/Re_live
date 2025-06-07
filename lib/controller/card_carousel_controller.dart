import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../database/drift_database.dart';
import '../widget/scheduled_cards/completed_scheduled_list_items.dart';
import '../widget/scheduled_cards/journal_card.dart';
import '../widget/scheduled_cards/upcoming_scheduled_list_items.dart';
import 'db_journal_controller.dart';

class CardCarouselController extends GetxController {
  static CardCarouselController get to => Get.find<CardCarouselController>();
  final RxDouble cardCarouselScale = 1.0.obs;
  final RxDouble cardPadding = 0.0.obs;
  final RxDouble scrollAngle = 0.0.obs;
  final RxDouble maxScrollExtent = 1.0.obs;
  final RxInt lastIndex = 0.obs;
  final Rx<ScrollController?> scrollController = Rx<ScrollController?>(null);
  final RxString nowCardType = "".obs;
  final RxInt nowCardIndex = 0.obs;

  final items1 = <Widget>[].obs;
  final items2 = <Widget>[].obs;
  final item3 = Rxn<Widget>();
  final combinedItems = <Widget>[].obs;


  void setScale(double value) {
    cardCarouselScale.value = value;
  }

  void setCardPadding(double value) {
    cardPadding.value = value;
  }


  void setScrollController(ScrollController controller) {
    scrollController.value = controller;
  }

  void updateMaxExtent(double extent) {
    maxScrollExtent.value = extent;
  }

  void updateAngle(double angle) {
    // 0~360도 제한
    angle = angle.clamp(0, 360);
    scrollAngle.value = angle;

    // 스크롤 위치 계산
    final controller = scrollController.value;
    final maxExtent = maxScrollExtent.value;
    if (controller != null && controller.hasClients) {
      final targetOffset = (angle / 360) * maxExtent;
      controller.jumpTo(targetOffset);
    }
  }

  void syncScrollToAngle(double offset) {
    final maxExtent = maxScrollExtent.value;
    if (maxExtent > 0) {
      scrollAngle.value = (offset / maxExtent) * 360;
    }
  }



  Future<void> loadItems(BuildContext context) async {
    items1.value = CompletedScheduledListItems.build();
    items2.value = UpcomingScheduledListItems.build(context);
    item3.value = JournalCard();

    if (items1.isEmpty && items2.isEmpty) {
      combinedItems.value = [];
    } else if (items1.isNotEmpty && items2.isEmpty && item3.value != null) {
      combinedItems.value = [...items1, item3.value!];
      await _addJournal(); // 내부에서 재호출해도 반영
    } else {
      combinedItems.value = [...items1, ...items2];
    }
  }

  Future<void> _addJournal() async {
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    await DbJournalController.to.searchJournal(today);
    if (DbJournalController.to.journal.value != null) return;

    final newJournal = JournalCompanion(
      date: drift.Value(today),
      comment: drift.Value("오늘 하루에 대한 느낌점을 입력해주세요!"),
    );
    await DbJournalController.to.addJournal(newJournal);

    // item3 및 리스트 다시 갱신
    item3.value = JournalCard();
    combinedItems.value = [...items1, item3.value!];
  }



}
