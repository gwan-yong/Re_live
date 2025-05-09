import 'package:flutter/material.dart';
import 'package:re_live/screen/event_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import '../theme/colors.dart';
/*
class MainCalendar extends StatefulWidget {
  final Function(DateTime selectedDate) onDateSelected; // 콜백 함수 선언

  MainCalendar({required this.onDateSelected}); // 부모로부터 콜백 함수 받기

  @override
  _MainCalendarState createState() => _MainCalendarState();
}

class _MainCalendarState extends State<MainCalendar> {
  DateTime _focusedDay = DateTime.now(); // 상태 변수 선언

  final List<String> _weekdays = [
    '일', '월', '화', '수', '목', '금', '토'
  ]; // 요일 리스트

  final Map<DateTime, String> photoEvents = {
    DateTime.utc(2025, 4, 5): 'assets/img/sample2.jpeg',
    DateTime.utc(2025, 4, 4): 'assets/img/sample5.jpeg',
    DateTime.utc(2025, 4, 3): 'assets/img/sample1.jpeg',
    DateTime.utc(2025, 4, 2): 'assets/img/sample3.jpeg',
    DateTime.utc(2025, 4, 1): 'assets/img/sample4.jpeg',
  }; // 사진 리스트

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // 달력 상단 년, 월 표시
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_focusedDay.month}월',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_focusedDay.year}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                // 이전/다음 버튼
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month - 1,
                      );
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month + 1,
                      );
                    });
                  },
                ),
              ],
            ),
          ),

          // 요일 표시
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _weekdays.map((day) {
                return Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: day == '일'
                            ? Colors.red
                            : day == '토'
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 4),

          // 달력 일자 표시
          SizedBox(
            child: TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(1800, 1, 1),
              lastDay: DateTime(3000, 1, 1),
              headerVisible: false,
              daysOfWeekVisible: false,
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, _) {
                  final imagePath = photoEvents[day];

                  if (imagePath != null) {
                    // 썸네일만 표시 (숫자 없이)
                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all( // 테두리 설정
                            color: Colors.black, // 테두리 색상
                            width: 2, // 테두리 두께
                          ),
                          borderRadius: BorderRadius.circular(16), // 테두리 둥글게 만들기
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text('${day.day}'));
                  }
                },
              ),
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = selectedDay; // 선택된 날짜로 업데이트
                });
                widget.onDateSelected(selectedDay); // 부모로 날짜 전달
              },
            ),
          ),

          SizedBox(height: 10),

          Container(
            height: 4,
            color: secondaryColor,
          ),

          // 하단 오늘 날짜 표시
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${_focusedDay.day}일',
                ),
                Spacer(),
                // 일정 추가 버튼
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventScreen()),
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/


class MainCalendar extends StatefulWidget {
  final Function(DateTime selectedDate) onDateSelected; // 콜백 함수 선언

  MainCalendar({required this.onDateSelected}); // 부모로부터 콜백 함수 받기

  @override
  _MainCalendarState createState() => _MainCalendarState();
}

class _MainCalendarState extends State<MainCalendar> {
  DateTime _focusedDay = DateTime.now(); // 상태 변수 선언
  DateTime? _selectedDay; // 선택된 날짜를 저장할 변수

  final List<String> _weekdays = [
    '일', '월', '화', '수', '목', '금', '토'
  ]; // 요일 리스트

  final Map<DateTime, String> photoEvents = {
    DateTime.utc(2025, 4, 5): 'assets/img/sample2.jpeg',
    DateTime.utc(2025, 4, 4): 'assets/img/sample5.jpeg',
    DateTime.utc(2025, 4, 3): 'assets/img/sample1.jpeg',
    DateTime.utc(2025, 4, 2): 'assets/img/sample3.jpeg',
    DateTime.utc(2025, 4, 1): 'assets/img/sample4.jpeg',
  }; // 사진 리스트

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // 달력 상단 년, 월 표시
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_focusedDay.month}월',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_focusedDay.year}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                // 이전/다음 버튼
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month - 1,
                      );
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month + 1,
                      );
                    });
                  },
                ),
              ],
            ),
          ),

          // 요일 표시
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _weekdays.map((day) {
                return Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: day == '일'
                            ? Colors.red
                            : day == '토'
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 4),

          // 달력 일자 표시
          SizedBox(
            child: TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(1800, 1, 1),
              lastDay: DateTime(3000, 1, 1),
              headerVisible: false,
              daysOfWeekVisible: false,
              selectedDayPredicate: (day) {
                // 선택된 날짜를 비교하여 강조할 날짜를 결정
                return _selectedDay != null && isSameDay(_selectedDay!, day);
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, _) {
                  final imagePath = photoEvents[day];

                  if (imagePath != null) {
                    // 썸네일만 표시 (숫자 없이)
                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all( // 테두리 설정
                            color: Colors.black, // 테두리 색상
                            width: 2, // 테두리 두께
                          ),
                          borderRadius: BorderRadius.circular(16), // 테두리 둥글게 만들기
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text('${day.day}'));
                  }
                },
              ),
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = focusedDay; // 선택된 날짜로 업데이트
                  _selectedDay = selectedDay; // 선택된 날짜 상태 업데이트
                });
                widget.onDateSelected(selectedDay); // 부모로 날짜 전달
              },
            ),
          ),

          SizedBox(height: 10),

          Container(
            height: 4,
            color: secondaryColor,
          ),

          // 하단 오늘 날짜 표시
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${_focusedDay.day}일',
                ),
                Spacer(),
                // 일정 추가 버튼
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventScreen()),
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}