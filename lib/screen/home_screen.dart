import 'package:flutter/material.dart';
import 'package:re_live/screen/calendar_screen.dart';
import 'package:re_live/widget/completed_event_list.dart';
import 'package:re_live/widget/scheduled_event_list.dart';
import '../database/drift_database.dart';
import '../widget/fab_menu_button.dart';

class HomeScreen extends StatelessWidget{
  HomeScreen({super.key});
  final LocalDatabase database = LocalDatabase();
  final DateTime selectedDate = DateTime.now();

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            top: true,
            bottom: false,
            child: Container(
              margin: EdgeInsets.all(0),
              child: ListView(
                scrollDirection: Axis.vertical, //세로 스크롤
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _title(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                            '오늘 진행된 일정'
                        ),
                      ),
                      CompletedEventList(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                            '오늘 진행 예정 일정'
                        ),
                      ),
                      ScheduledEventList(
                          isScrollable: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          FAButtonMenu(),
        ],
      ),
    );
  }
}

class _title extends StatelessWidget{
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async{
              print("----------------------");
              List<ScheduledData> schedules = await LocalDatabase().getAllSchedules();
              for (var schedule in schedules) {
                print('일정 id:${schedule.id} 제목: ${schedule.title}''날짜: ${schedule.date}');
              }
              print("-------");
              List<CompletedScheduledData> completeSchedules = await LocalDatabase().getAllCompletePhotos();
              for (var schedule in completeSchedules) {
                print('완료 id:${schedule.id} 일정 id:${schedule.scheduledId} 날짜: ${schedule.takenAt}');
              }
              print("-------");
              List<ScheduledData> nowSchedules = await LocalDatabase().getSchedulesByDate(DateTime.now());
              for (var schedule in nowSchedules) {
                print('일정 id:${schedule.id} '
                    '제목: ${schedule.title}'
                    '날짜: ${schedule.date}'
                );
              }
              print("-------");
              List<ScheduledData> lateSchedules = await LocalDatabase().getTodayLateSchedules();
              for (var schedule in lateSchedules) {
                print('놓친 일정 id:${schedule.id} '
                    '제목: ${schedule.title}'
                    '날짜: ${schedule.date}'
                );
              }
              print("----------------------");

            },
            child: Text(
              'ReLive',
              textAlign: TextAlign.left,
              style : TextStyle(
                fontSize : 50.0,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarScreen()),
              );
            },
            icon: Icon(Icons.calendar_month),
            iconSize: 40,

          ),
        ],
      ),
    );
  }
}

