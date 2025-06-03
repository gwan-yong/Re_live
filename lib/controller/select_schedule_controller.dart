import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectScheduleController extends GetxController {
  static SelectScheduleController get to => Get.find();

  late RxInt id;
  late RxString title;
  late Rx<Color> color;
  late Rx<DateTime> selectDate;
  late Rx<TimeOfDay> startTime;
  late RxBool endUsed;
  late final Rx<TimeOfDay?> endTime = Rx<TimeOfDay?>(null);
  late RxString repeatType;
  late RxBool repeatEndUsed;
  late final Rx<DateTime?> repeatEndDate = Rx<DateTime?>(null);



  SelectScheduleController({
    int initialId = 0,
    String initialTitle = '',
    Color initialColor = Colors.white,
    DateTime? initialDate,
    TimeOfDay? initialStartTime,
    bool initialEndUsed = false,
    String initialRepeatType = '없음',
    bool initialRepeatEndUsed = false,
  }) {
    id = initialId.obs;
    title = initialTitle.obs;
    color = initialColor.obs;
    selectDate = (initialDate ?? DateTime.now()).obs;
    startTime = (initialStartTime ?? TimeOfDay.now()).obs;
    endUsed = initialEndUsed.obs;
    repeatType = initialRepeatType.obs;
    repeatEndUsed = initialRepeatEndUsed.obs;

    // 디버깅용 print
    print('[SelectScheduleController] 초기화 완료');
    print('📌 id 설정됨: ${id.value}');
    print('📌 title 설정됨: ${title.value}');
    print('📌 color 설정됨: ${color.value}');
    print('📌 selectDate 설정됨: ${selectDate.value}');
    print('📌 startTime 설정됨: ${Get.context != null ? startTime.value.format(Get.context!) : startTime.value}');
    print('📌 endUsed 설정됨: ${endUsed.value}');
    print('📌 repeatType 설정됨: ${repeatType.value}');
    print('📌 repeatEndUsed 설정됨: ${repeatEndUsed.value}');
    print('📌 endTime 설정됨: ${Get.context != null ? startTime.value.format(Get.context!) : endTime?.value}');
    print('📌 repeatEndDate 설정됨: ${repeatEndDate.value}');
  }

  void onInit() {
    super.onInit();
    // Rx 값이 변경될 때마다 print 로그 출력
    id.listen((value) => print('📌 id 변경됨: $value'));
    title.listen((value) => print('📌 title 변경됨: $value'));
    color.listen((value) => print('📌 color 변경됨: $value'));
    selectDate.listen((value) => print('📌 selectDate 변경됨: $value'));
    startTime.listen(
      (value) => print('📌 startTime 변경됨: ${Get.context != null ? value.format(Get.context!) : value}'),
    );
    endUsed.listen((value) => print('📌 endUsed 변경됨: $value'));
    repeatType.listen((value) => print('📌 repeatType 변경됨: $value'));
    repeatEndUsed.listen((value) => print('📌 repeatEndUsed 변경됨: $value'));
    endTime.listen((value) {
      print('📌 endTime 변경됨: ${value != null && Get.context != null ? value.format(Get.context!) : value }');
    });
    repeatEndDate?.listen((value) => print('📌 repeatEndDate 변경됨: $value'));
  }

  /// 컨트롤러 상태를 초기 상태로 되돌리는 메서드
  void reset() {
    id.value = 0;
    title.value = '';
    color.value = Colors.white;
    selectDate.value = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
    startTime.value = TimeOfDay.now();
    endUsed.value = false;
    endTime.value = null;
    repeatType.value = '없음';
    repeatEndUsed.value = false;
    repeatEndDate.value = null;
    print('[SelectScheduleController] reset() 호출됨 - 상태 초기화 완료');
  }





}
