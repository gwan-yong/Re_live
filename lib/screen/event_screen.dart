import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_color_picker/show_ios_color_picker.dart';
import 'package:re_live/widget/event_setting/date_setting.dart';
import 'package:re_live/widget/event_setting/repeat_setting.dart';
import '../theme/colors.dart';
import '../widget/event_setting/event_title.dart';
import 'home_screen.dart';

class EventScreen extends StatefulWidget {
  State<EventScreen> createState() => _EventScreen();
}

class _EventScreen extends State<EventScreen> {
  Color backgroundColor = appBackgroundColor;
  IOSColorPickerController iosColorPickerController =
  IOSColorPickerController();

  @override
  void dispose() {
    iosColorPickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: Text("일정"), backgroundColor: backgroundColor),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EventTitle(
                  backgroundColor: backgroundColor,
                  onColorChanged: (color) {
                    setState(() => backgroundColor = color);
                  },
                ),
                DateSetting(),
                RepeatSetting(),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen())
                    );
                  },
                  child:
                  Container(
                    width: 348,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(child: Text('등록')),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}






