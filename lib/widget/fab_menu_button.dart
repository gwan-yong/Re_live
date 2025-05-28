import 'dart:math';
import 'package:flutter/material.dart';
import 'package:re_live/screen/camera_screen.dart';
import 'package:re_live/screen/scheduled_detail_screen.dart';
import 'package:re_live/screen/journal_screen.dart';

class FAButtonMenu extends StatefulWidget {
  const FAButtonMenu({super.key});

  @override
  State<FAButtonMenu> createState() => _FAButtonMenuState();
}

class _FAButtonMenuState extends State<FAButtonMenu>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  final double radius = 100;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  void toggleMenu() {
    setState(() {
      isOpen = !isOpen;
      isOpen ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // ✨ 반투명 배경
        if (isOpen)
          GestureDetector(
            onTap: toggleMenu,
            child: Container(
              color: Colors.black.withOpacity(0.3),
              width: double.infinity,
              height: double.infinity,
            ),
          ),

        // ✨ 확장 FAB들
        ..._buildExpandableFABs(
          children: [
            FABItem(
              icon: Icons.edit,
              label: '글쓰기',
              action: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JournalScreen()),
              ),
            ),
            FABItem(
              icon: Icons.camera_alt,
              label: '사진 찍기',
              action: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CameraScreen()),
              ),
            ),
            FABItem(
              icon: Icons.event,
              label: '일정 보기',
              action: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScheduledDetailScreen()),
              ),
            ),
          ],
        ),

        // ✨ 중앙 FAB
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 150,
            height: 150,
            padding: const EdgeInsets.only(bottom: 50),
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              elevation: 50,
              shape: CircleBorder(),
              onPressed: toggleMenu,
              child: Icon(
                isOpen ? Icons.close : Icons.add,
                size: 70,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildExpandableFABs({required List<FABItem> children}) {
    List<Widget> fabs = [];

    final double startAngle = 30 * (pi / 180); // 시작 각도
    final double sweep = 120 * (pi / 180); // 총 펼치는 각도

    // FAB 위치 자동 계산
    for (int i = 0; i < children.length; i++) {
      final double angle = startAngle + (sweep / (children.length - 1)) * i;
      final double dx = radius * cos(angle);
      final double dy = radius * sin(angle);

      fabs.add(
        Positioned(
          bottom: 100 + dy, // 토글 버튼 기준으로 offset
          left: MediaQuery.of(context).size.width / 2 - 28 + dx,
          child: ScaleTransition(
            scale: _animation,
            child: FloatingActionButton(
              shape: CircleBorder(),
              heroTag: 'fab_$i',
              backgroundColor: Colors.white,
              onPressed: () {
                toggleMenu(); // 먼저 메뉴 닫기
                children[i].action(); //  전달된 action 실행
              },
              child: Icon(children[i].icon, color: Colors.black),
            ),
          ),
        ),
      );
    }
    return fabs;
  }
}

class FABItem {
  final IconData icon;
  final String label;
  final VoidCallback action;

  FABItem({
    required this.icon,
    required this.label,
    required this.action,
  });
}