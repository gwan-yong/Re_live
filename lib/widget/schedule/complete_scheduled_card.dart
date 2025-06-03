import 'package:flutter/material.dart';
import 'package:re_live/widget/schedule/complete_scheduled_photo.dart';

class CompleteScheduledCard extends StatelessWidget {
  final String? rearimgPath;
  final String? frontimgPath;
  final String title;
  final Color color;
  final String takenAt;
  final String? lateCommet;

  const CompleteScheduledCard({
    this.rearimgPath,
    this.frontimgPath,
    required this.title,
    required this.color,
    required this.takenAt,
    this.lateCommet,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print(rearimgPath);
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          width: width,
          height: height,
          padding: rearimgPath != null && rearimgPath!.isNotEmpty ? const EdgeInsets.all(1) : const EdgeInsets.only(top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (rearimgPath != null && rearimgPath!.isNotEmpty)
                CompleteScheduledPhoto(
                  rearimgPath: rearimgPath!,
                  frontimgPath: frontimgPath!,
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Text(title, style: const TextStyle(fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(takenAt, style: const TextStyle(fontSize: 11)),
              ),
              if (lateCommet != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '일정을 놓친 이유',
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
              if (lateCommet != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    lateCommet!,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
