import 'package:flutter/material.dart';
import 'package:re_live/screen/calendar_screen.dart';
import 'package:re_live/screen/event_screen.dart';
import 'package:re_live/widget/completed_event_list.dart';
import 'package:re_live/widget/scheduled_event_list.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key ? key}) : super(key: key);

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EventScreen()),
          );
        },
        child: Icon(Icons.add),
        elevation: 50, //떠있는 정도 조절
        shape: CircleBorder(),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //flotingActionBotton 위치 조정
      body: SafeArea(
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
                  ScheduledEventList(isScrollable: false),
                ],
              ),
            ],
          ),
        ),
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
          Text(
            'ReLive',
            textAlign: TextAlign.left,
            style : TextStyle(
              fontSize : 50.0,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalendarScreen()),
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

