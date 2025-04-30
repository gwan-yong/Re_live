import 'package:flutter/material.dart';

class MissedEventList extends StatelessWidget {
  final bool isScrollable; // 스크롤 가능 여부 설정용 매개변수

  MissedEventList({this.isScrollable = true}); // 기본값은 스크롤 가능

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
          _EventTile('운동하기', '오후 7시', '컨디션 안 좋음', Colors.red),
        ],
      ),
    );
  }

  // 반복되는 Container 생성을 함수로 분리
  Widget _EventTile(String title, String time, String missedNote, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      height: 110,
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
          Text('사유 : $missedNote ' ),
        ],
      ),
    );
  }
}