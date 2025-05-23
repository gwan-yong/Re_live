import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_color_picker/show_ios_color_picker.dart';

import '../../theme/colors.dart';

/*
class EventTitle extends StatelessWidget {
  final Color backgroundColor;
  final Function(Color) onColorChanged;

  const EventTitle({
    Key? key,
    required this.backgroundColor,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 104,
        width: 350,
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 2.0,
        ),
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
                decoration: InputDecoration(
                  hintText: '제목',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 20,
                  ),
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
                      startingColor: backgroundColor,
                      onColorChanged: (color) {
                        onColorChanged(color);
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "일정 색상",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        width: 225,
                        child: Text(''),
                      ),
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
}*/

class EventTitle extends StatelessWidget {
  final Color backgroundColor;
  final Function(Color) onColorChanged;
  final Function(String) onTitleChanged; // 🔸 추가: 제목이 바뀔 때 상위로 전달할 콜백

  const EventTitle({
    Key? key,
    required this.backgroundColor,
    required this.onColorChanged,
    required this.onTitleChanged, // 🔸 필수 파라미터로 받음
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 104,
        width: 350,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 2.0,
        ),
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
                onChanged: (value) {
                  onTitleChanged(value); // 🔸 제목 입력이 바뀔 때마다 상위에 전달
                },
                onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                decoration: InputDecoration(
                  hintText: '제목',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontSize: 20,
                  ),
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
                      startingColor: backgroundColor,
                      onColorChanged: (color) {
                        onColorChanged(color); // 🔸 색상 변경 시 상위에 전달
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "일정 색상",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      const Icon(CupertinoIcons.paintbrush),
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