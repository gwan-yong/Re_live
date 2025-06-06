import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardCarouselController extends GetxController {
  static CardCarouselController get to => Get.find<CardCarouselController>();
  final RxDouble cardCarouselScale = 1.0.obs;
  final RxDouble cardPadding = 0.0.obs;
  final RxDouble scrollAngle = 0.0.obs;
  final RxDouble maxScrollExtent = 1.0.obs;
  final RxInt lastIndex = 0.obs;
  final Rx<ScrollController?> scrollController = Rx<ScrollController?>(null);

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


}
