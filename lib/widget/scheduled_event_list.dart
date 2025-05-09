/*
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/drift_database.dart'; // 시간 포맷을 위한 패키지

class ScheduledEventList extends StatelessWidget {
  final LocalDatabase database;
  final bool isScrollable;

  ScheduledEventList({
    required this.database,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScheduledData>>(
      future: database.getTodaySchedules(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // 로딩 중
        }

        if (snapshot.hasError) {
          return Center(child: Text('오류 발생: ${snapshot.error}')); // 오류 처리
        }

        final schedules = snapshot.data ?? [];

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            physics: isScrollable
                ? AlwaysScrollableScrollPhysics()
                : NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: schedules.map((schedule) {
              final startTime = _formatTime(schedule.startTime);
              final endTime = _formatTime(schedule.endTime);
              final color = Color(schedule.color ?? 0xFFCCCCCC); // color가 null일 수 있음

              return _EventTile(
                schedule.title,
                startTime,
                schedule.endUsed,
                endTime,
                color,
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // 시간(정수)을 "오후 6시" 같은 텍스트로 변환
  String _formatTime(int rawTime) {
    final hour = rawTime ~/ 60;
    final minute = rawTime % 60;
    final time = TimeOfDay(hour: hour, minute: minute);
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm('ko').format(dt); // '오전 6:00' 같은 형식
  }

  // 동일한 _EventTile
  Widget _EventTile(String title, String startTime, bool endUsed, String endTime, Color color) {
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
          Row(
            children: [
              Text(startTime),
              if (endUsed) Text(" ~ $endTime"),
            ],
          ),
        ],
      ),
    );
  }
}*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/drift_database.dart';

class ScheduledEventList extends StatelessWidget {
  final LocalDatabase database;
  final bool isScrollable;
  final DateTime selectedDate; // 부모에서 선택한 날짜를 받기 위한 변수

  ScheduledEventList({
    required this.database,
    required this.selectedDate, // 선택된 날짜를 매개변수로 받음
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScheduledData>>(
      future: database.getSchedulesByDate(selectedDate), // 선택된 날짜에 맞는 데이터를 가져옴
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // 로딩 중
        }

        if (snapshot.hasError) {
          return Center(child: Text('오류 발생: ${snapshot.error}')); // 오류 처리
        }

        final schedules = snapshot.data ?? [];

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            physics: isScrollable
                ? AlwaysScrollableScrollPhysics()
                : NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: schedules.map((schedule) {
              final startTime = _formatTime(schedule.startTime);
              final endTime = _formatTime(schedule.endTime);
              final color = Color(schedule.color ?? 0xFFCCCCCC); // color가 null일 수 있음

              return _EventTile(
                schedule.title,
                startTime,
                schedule.endUsed,
                endTime,
                color,
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // 시간(정수)을 "오후 6시" 같은 텍스트로 변환
  String _formatTime(int rawTime) {
    final hour = rawTime ~/ 60;
    final minute = rawTime % 60;
    final time = TimeOfDay(hour: hour, minute: minute);
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm('ko').format(dt); // '오전 6:00' 같은 형식
  }

  // 동일한 _EventTile
  Widget _EventTile(String title, String startTime, bool endUsed, String endTime, Color color) {
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
          Row(
            children: [
              Text(startTime),
              if (endUsed) Text(" ~ $endTime"),
            ],
          ),
        ],
      ),
    );
  }
}