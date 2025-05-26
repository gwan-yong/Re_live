import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/drift_database.dart';
import '../notification.dart';

class ScheduledEventList extends StatelessWidget {
  final LocalDatabase database;
  final bool isScrollable; //스크롤 사용 유무 변수
  final DateTime selectedDate; // 부모에서 선택한 날짜를 받기 위한 변수

  ScheduledEventList({
    required this.database,
    required this.selectedDate,
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

        //오늘 알림 등록
        final DateTime now = DateTime.now();

        for (final schedule in schedules) {
          final scheduledStart = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            schedule.startTime ~/ 60,
            schedule.startTime % 60,
          );

          DateTime? scheduledEnd;
          if (schedule.endUsed && schedule.endTime != null) {
            scheduledEnd = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              schedule.endTime! ~/ 60,
              schedule.endTime! % 60,
            );
          }

          if (scheduledStart.isAfter(now)) {
            //일정 알림 등록
            showScheduledNotification(
              schedule.id,
              scheduledStart,
              schedule.title,
            );
          }
          //놓친 일정 알림 예약 등록
          if (!schedule.endUsed) {
            // 종료 시간 미사용 시: 시작 30분 이후이면 놓침
            showMissedScheduleNotification(
              schedule.id,
              schedule.title,
              scheduledStart.add(Duration(minutes: 1)),
              _formatTime(schedule.startTime),
              schedule.endUsed,
              _formatTime(schedule.endTime),
              schedule.color ?? 0,
            );
          } else if (scheduledEnd != null) {
            // 종료 시간 사용 시: 종료 시간이 지났다면 놓침
            showMissedScheduleNotification(
              schedule.id,
              schedule.title,
              scheduledEnd,
              _formatTime(schedule.startTime),
              schedule.endUsed,
              _formatTime(schedule.endTime),
              schedule.color ?? 0,
            );
          }
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            physics:
                isScrollable
                    ? AlwaysScrollableScrollPhysics()
                    : NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children:
                schedules.map((schedule) {
                  return Container(
                    child: ListView(
                      physics: isScrollable
                          ? AlwaysScrollableScrollPhysics()
                          : NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: schedules.map((schedule) {
                        final startTime = _formatTime(schedule.startTime);
                        final endTime = _formatTime(schedule.endTime);
                        final color = Color(schedule.color ?? 0xFFCCCCCC);

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
                }).toList(),
          ),
        );
      },
    );
  }

  // 시간(정수)을 "오후 6시" 같은 텍스트로 변환
  String _formatTime(int? rawTime) {

    if (rawTime == null) return '-'; // 또는 '' 빈 문자열 등

    final hour = rawTime ~/ 60;
    final minute = rawTime % 60;
    final time = TimeOfDay(hour: hour, minute: minute);
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm('ko').format(dt); // '오전 6:00' 같은 형식
  }

  // 동일한 _EventTile
  Widget _EventTile(
    String title,
    String startTime,
    bool endUsed,
    String endTime,
    Color color,
  ) {
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
          Text(title, style: TextStyle(fontSize: 25)),
          Row(children: [Text(startTime), if (endUsed) Text(" ~ $endTime")]),
        ],
      ),
    );
  }
}
