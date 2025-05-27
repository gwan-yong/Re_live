import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:re_live/widget/event_setting/date_setting.dart';
import 'package:re_live/widget/event_setting/repeat_setting.dart';
import '../controller/db_complete_schedule_controller.dart';
import '../controller/db_schedule_controller.dart';
import '../controller/select_schedule_controller.dart';
import '../database/drift_database.dart';
import '../widget/event_setting/event_title.dart';
import 'package:drift/drift.dart' as drift;
import 'home_screen.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final selectId = SelectScheduleController.to.id.value;
  bool _showDeleteOptions = false;
  bool _showUpdateOptions = false;
  bool _UpdateOptions = false;

  int timeOfDayToInt(TimeOfDay tod) => tod.hour * 60 + tod.minute;

  bool _isValid() => SelectScheduleController.to.title.value.trim().isNotEmpty;

  void initState() {
    super.initState();
    if (selectId >= 1) {
      _UpdateOptions = true;
    }
  }

  @override
  void dispose() {
    SelectScheduleController.to.reset(); // 초기화
    super.dispose();
  }

  Future<void> _handleSingleDelete() async {
    final id = SelectScheduleController.to.id.value;
    final newComplete = CompletedScheduledCompanion(
      scheduledId: drift.Value(id),
      takenAt: drift.Value(SelectScheduleController.to.selectDate.value),
      notDisplay: const drift.Value(true),
    );

    await DbCompleteScheduleController.to.addCompleteSchedule(newComplete);
    _navigateHome();
  }

  Future<void> _handleFullDelete() async {
    final id = SelectScheduleController.to.id.value;
    await DbScheduleController.to.deleteSchedule(id);
    _navigateHome();
  }

  Future<void> _handleSingleUpdate() async {
    _handleSingleDelete();
    final sc = SelectScheduleController.to;
    final newSchedule = ScheduledCompanion(
      title: drift.Value(sc.title.value),
      color: drift.Value(sc.color.value.value),
      date: drift.Value(sc.selectDate.value),
      startTime: drift.Value(timeOfDayToInt(sc.startTime.value)),
      endUsed: drift.Value(sc.endUsed.value),
      endTime:
      sc.endTime.value == null
          ? const drift.Value.absent()
          : drift.Value(timeOfDayToInt(sc.endTime.value!)),
    );
    await DbScheduleController.to.addSchedule(newSchedule);
    _navigateHome();
  }

  Future<void> _handleFullUpdate() async {
    final sc = SelectScheduleController.to;
    final newSchedule = ScheduledCompanion(
      title: drift.Value(sc.title.value),
      color: drift.Value(sc.color.value.value),
      date: drift.Value(sc.selectDate.value),
      startTime: drift.Value(timeOfDayToInt(sc.startTime.value)),
      endUsed: drift.Value(sc.endUsed.value),
      endTime:
      sc.endTime.value == null
          ? const drift.Value.absent()
          : drift.Value(timeOfDayToInt(sc.endTime.value!)),
      repeatType: drift.Value(sc.repeatType.value),
      repeatEndUsed: drift.Value(sc.repeatEndUsed.value),
      repeatEndDate: drift.Value(sc.repeatEndDate.value),
    );
    await DbScheduleController.to.updateSchedule(sc.id.value,newSchedule);
    _navigateHome();
  }



  void _navigateHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  Widget _buildDeleteButtons() {
    return Column(
      children: [
        _buildActionButton('이 일정만 삭제', Colors.red, _handleSingleDelete),
        _buildActionButton('모든 반복 삭제', Colors.orange, _handleFullDelete),
      ],
    );
  }

  Widget _buildUpdateButtons() {
    return Column(
      children: [
        _buildActionButton('이 일정만 적용', Colors.red, _handleSingleUpdate),
        _buildActionButton('모든 반복 일정 적용', Colors.orange, _handleFullUpdate),
      ],
    );
  }


  Widget _buildActionButton(String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 350,
        height: 50,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildDeleteToggleButton(), Obx(() => _buildSubmitButton())],
    );
  }

  Widget _buildDeleteToggleButton() {
    return GestureDetector(
      onTap: () async {
        if (selectId >= 1) {
          final schedule = await DbScheduleController.to.searchSchedule(
            selectId,
          );
          if (schedule?.repeatType == "없음") {
            await DbScheduleController.to.deleteSchedule(schedule!.id);
            _navigateHome();
          } else {
            setState(() => _showDeleteOptions = !_showDeleteOptions);
          }
        }
      },
      child: Container(
        width: 168,
        height: 50,
        decoration: BoxDecoration(
          color:
              _isValid()
                  ? Colors.white.withOpacity(0.5)
                  : Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            _showDeleteOptions ? '취소' : '삭제',
            style: TextStyle(
              color: _isValid() ? Colors.black : Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return AbsorbPointer(
      absorbing: !_isValid(),
      child: GestureDetector(
        onTap: () async {
          final sc = SelectScheduleController.to;
          final newSchedule = ScheduledCompanion(
            title: drift.Value(sc.title.value),
            color: drift.Value(sc.color.value.value),
            date: drift.Value(sc.selectDate.value),
            startTime: drift.Value(timeOfDayToInt(sc.startTime.value)),
            endUsed: drift.Value(sc.endUsed.value),
            endTime:
                sc.endTime.value == null
                    ? const drift.Value.absent()
                    : drift.Value(timeOfDayToInt(sc.endTime.value!)),
            repeatType: drift.Value(sc.repeatType.value),
            repeatEndUsed: drift.Value(sc.repeatEndUsed.value),
            repeatEndDate: drift.Value(sc.repeatEndDate.value),
          );

          if(_UpdateOptions){
            //기존의 일정을 불러와서 일정을 업데이트
            setState(() => _showUpdateOptions = !_showUpdateOptions);
          }
          else{
            //기존 일정이 없고 새로운 일정이기 떄문에 일정 추가
            await DbScheduleController.to.addSchedule(newSchedule);
            _navigateHome();
          }
        },
        child: Container(
          width: 168,
          height: 50,
          decoration: BoxDecoration(
            color:
                _isValid()
                    ? Colors.white.withOpacity(0.5)
                    : Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              !_UpdateOptions
                  ? '등록'
                  : (_showUpdateOptions ? '취소' : '수정'),
              style: TextStyle(
                color: _isValid() ? Colors.black : Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bgColor = SelectScheduleController.to.color.value;
      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(title: const Text("일정"), backgroundColor: bgColor),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    EventTitle(),
                    DateSetting(),
                    RepeatSetting(),
                    const SizedBox(height: 30),
                    if (_showDeleteOptions) _buildDeleteButtons(),
                    if (_showUpdateOptions) _buildUpdateButtons(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: _buildControlButtons(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
