import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/card_carousel_controller.dart';

class RotatingDial extends StatefulWidget {
  final double size;
  final VoidCallback? onCenterTap;

  const RotatingDial({Key? key, this.size = 200, this.onCenterTap}) : super(key: key);

  @override
  State<RotatingDial> createState() => _RotatingDialState();
}

class _RotatingDialState extends State<RotatingDial> {
  Offset center = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        RenderBox box = context.findRenderObject() as RenderBox;
        center = box.size.center(Offset.zero);
        final touchPoint = details.localPosition;
        final distance = (touchPoint - center).distance;
        // 중심 반지름 40 이내 클릭 시 onCenterTap 호출
        if (distance < 10.0) {
          widget.onCenterTap?.call();
        }
      },
      onPanStart: (details) {
        RenderBox box = context.findRenderObject() as RenderBox;
        center = box.size.center(Offset.zero);
      },
      onPanUpdate: (details) {
        final Offset localPosition = details.localPosition;
        final Offset delta = localPosition - center;

        final newAngle = (atan2(delta.dy, delta.dx) * 180 / pi + 450) % 360;
        final currentAngle = CardCarouselController.to.scrollAngle.value;
        final angleDelta = (newAngle - currentAngle + 540) % 360 - 180;

        final proposedAngle = (currentAngle + angleDelta) % 360;

        // clamp 범위
        const minAngle = 0.0;
        const maxAngle = 360.0;
        const tolerance = 0.5;

        final isAtMin = currentAngle <= minAngle + tolerance;
        final isAtMax = currentAngle >= maxAngle - tolerance;

        final tryingToDecrease = angleDelta < 0;
        final tryingToIncrease = angleDelta > 0;

        if ((isAtMin && tryingToDecrease) || (isAtMax && tryingToIncrease)) {
          return;
        }

        // 컨트롤러를 통해 각도 업데이트 (자동으로 스크롤과도 동기화됨)
        CardCarouselController.to.updateAngle(proposedAngle.clamp(minAngle, maxAngle));
      },
      child: Obx(() {
        final angleRad = CardCarouselController.to.scrollAngle.value * pi / 180;
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _DialPainter(angle: angleRad),
        );
      }),
    );
  }
}

class _DialPainter extends CustomPainter {
  final double angle;

  _DialPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    // 그라데이션 페인트
    final Rect gradientRect = Rect.fromCircle(center: center, radius: radius);
    final Paint gradientPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment(0.0, -0.4),
        radius: 1.0,
        colors: [
          Color(0xFFE8B8FF), // 분홍빛 (상단 우측)
          Color(0xFF84F1E3), // 민트빛 (상단 좌측)
          Color(0xFF3D82FF), // 파란색 (하단)
        ],
        stops: [0.0, 0.5, 1.0],
      ).createShader(gradientRect)
      ..style = PaintingStyle.fill;

    // 원형 그라데이션 배경
    canvas.drawCircle(center, radius, gradientPaint);

    // 핸들 위치 계산
    final double adjustedAngle = angle - pi / 2;
    final double handleRadius = 5.0;
    final double handleLength = radius - 16;

    final double handleX = center.dx + handleLength * cos(adjustedAngle);
    final double handleY = center.dy + handleLength * sin(adjustedAngle);

    final Paint handlePaint = Paint()..color = Colors.white;

    // 핸들 원 그리기
    canvas.drawCircle(Offset(handleX, handleY), handleRadius, handlePaint);
  }

  @override
  bool shouldRepaint(covariant _DialPainter oldDelegate) {
    return oldDelegate.angle != angle;
  }
}
