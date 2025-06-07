import 'package:flutter/material.dart';
import 'package:re_live/controller/card_carousel_controller.dart';
import 'package:re_live/screen/scheduled_detail_screen.dart';
import '../../controller/select_schedule_controller.dart';
import 'date_circular_dial.dart';
import 'journal_widget.dart';
import 'main_calendar.dart';
import '../../screen/camera_screen.dart';


class BottomArea extends StatefulWidget {
  final VoidCallback? onCalendarOpened;
  final VoidCallback? onCalendarClosed;
  const BottomArea({
    super.key,
    this.onCalendarOpened,
    this.onCalendarClosed,
  });

  @override
  State<BottomArea> createState() => _BottomAreaState();
}

class _BottomAreaState extends State<BottomArea> with TickerProviderStateMixin {
  late AnimationController _dialController;
  late AnimationController _calendarController;
  late AnimationController _buttonController;

  late Animation<Offset> _dialOffsetAnimation;
  late Animation<Offset> _calendarOffsetAnimation;
  late Animation<Offset> _buttonOffsetAnimation;

  late AnimationController _journalController;
  late Animation<Offset> _journalOffsetAnimation;
  bool _showJournal = false;


  bool _showCalendar = false;
  bool _showDial = true;
  bool _showButtons = true;


  @override
  void initState() {
    super.initState();

    _dialController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _calendarController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _journalController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _dialOffsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _dialController,
      curve: Curves.easeInOut,
    ));

    _calendarOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _calendarController,
      curve: Curves.easeInOut,
    ));

    _buttonOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeInOut,
    ));

    _journalOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _journalController,
      curve: Curves.easeInOut,
    ));


  }

  @override
  void dispose() {
    _dialController.dispose();
    _calendarController.dispose();
    _buttonController.dispose();
    _journalController.dispose();
    super.dispose();
  }

  void _onEventPressed() async {
    await _buttonController.reverse();

    setState(() {
      _showButtons = false;
    });

    await _dialController.forward();

    setState(() {
      _showDial = false;
      _showCalendar = true;
    });


    widget.onCalendarOpened?.call();

    await _calendarController.forward();
  }

  void _onBackPressed() async {
    await _calendarController.reverse();

    setState(() {
      _showCalendar = false;
      _showDial = true;
    });

    widget.onCalendarClosed?.call();

    await _dialController.reverse();

    setState(() {
      _showButtons = true;
    });

    await _buttonController.forward();
  }

  void _onDialCenterTap() async {
    if(CardCarouselController.to.nowCardType.value == "journalCard"){
      await _buttonController.reverse();
      await _dialController.forward();

      setState(() {
        _showButtons = false;
        _showDial = false;
        _showJournal = true;
      });

      await _journalController.forward();
      widget.onCalendarOpened?.call();
    }
  }

  void _closeJournal() async {
    await _journalController.reverse();
    setState(() {
      _showJournal = false;
      _showDial = true;
    });
    await _dialController.reverse();
    setState(() {
      _showButtons = true;
    });
    widget.onCalendarClosed?.call();
    _buttonController.forward();
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_showButtons) {
      _buttonController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            // DateCircularDial + 버튼
            if (_showDial)
              SlideTransition(
                position: _dialOffsetAnimation,
                child: Stack(
                  children: [
                    DateCircularDial(
                      onCenterTap: _onDialCenterTap,
                    ),
                    Positioned(
                      bottom: 1,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: SlideTransition(
                          position: _buttonOffsetAnimation,
                          child: Visibility(
                            visible: _showButtons,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: _buildCircleIcon(Icons.camera_alt, () {
                                    Navigator.of(context).push(_createCameraRoute());
                                    SelectScheduleController.to.selectDate.value = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: _buildCircleIcon(Icons.event, _onEventPressed),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // MainCalendar + back button
            if (_showCalendar)
              SlideTransition(
                position: _calendarOffsetAnimation,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.keyboard_arrow_down, size: 32),
                              onPressed: _onBackPressed,
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade200, // 원하는 배경색
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScheduledDetailScreen(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.add),
                              color: Colors.black, // 아이콘 색상
                            ),
                          ),
                        )
                      ],
                    ),
                    const MainCalendar(),
                  ],
                ),
              ),
            if (_showJournal)
              SlideTransition(
                position: _journalOffsetAnimation,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.keyboard_arrow_down, size: 32),
                          onPressed: _closeJournal, // 중복된 로직 함수로 분리
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    JournalWidget(
                      onSubmit: _closeJournal, // 등록 후에도 닫기
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildCircleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        alignment: Alignment.center,
        child: Icon(icon),
      ),
    );
  }

  /// 카메라 화면 전환용 애니메이션 라우트
  Route _createCameraRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const CameraScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(
          begin: const Offset(0, 1), // 아래에서 시작
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
