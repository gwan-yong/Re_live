import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_color_picker/show_ios_color_picker.dart';
import '../../controller/select_schedule_controller.dart';
import '../../theme/colors.dart';

class EventTitle extends StatefulWidget {
  const EventTitle({super.key});

  @override
  State<EventTitle> createState() => _EventTitleState();
}

class _EventTitleState extends State<EventTitle> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    // 초기값 한 번만 세팅
    controller = TextEditingController(
      text: SelectScheduleController.to.title.value,
    );
  }

  @override
  void dispose() {
    controller.dispose(); // 메모리 누수 방지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 104,
        width: 350,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  SelectScheduleController.to.title.value = value;
                },
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                decoration: const InputDecoration(
                  hintText: '제목',
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 20),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(height: 0.5, color: secondaryColor),
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    IOSColorPickerController iosColorPickerController =
                    IOSColorPickerController();
                    iosColorPickerController.showIOSCustomColorPicker(
                      context: context,
                      startingColor: SelectScheduleController.to.color.value,
                      onColorChanged: (color) {
                        SelectScheduleController.to.color.value = color;
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "일정 색상",
                        style: TextStyle(color: Colors.black54, fontSize: 20),
                      ),
                      Spacer(),
                      Icon(CupertinoIcons.paintbrush),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
