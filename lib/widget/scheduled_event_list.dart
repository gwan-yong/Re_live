import 'package:flutter/material.dart';

class ScheduledEventList extends StatelessWidget {
  final bool isScrollable; // 스크롤 가능 여부 설정용 매개변수

  ScheduledEventList({this.isScrollable = true}); // 기본값은 스크롤 가능

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10),
      child: ListView(
        physics: isScrollable
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(), // 스크롤 설정
        shrinkWrap: true, // Column이나 다른 부모 위젯 안에서도 동작하도록 설정
        children: [
          _EventTile('저녁 먹기', '오후 6시', Colors.blue),
          _EventTile('운동하기', '오후 7시', Colors.red),
          _EventTile('공부하기', '오후 8시', Colors.green),
          _EventTile('샤워하기', '오후 9시', Colors.pink),
          _EventTile('일기 쓰기', '오후 10시', Colors.yellow),
        ],
      ),
    );
  }

  // 반복되는 Container 생성을 함수로 분리
  Widget _EventTile(String title, String time, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      height: 90,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 25),
          ),
          Text(time),
        ],
      ),
    );
  }
}