import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:re_live/widget/scheduled_cards/complete_scheduled_photo.dart';

class CompleteScheduledCard extends StatelessWidget {
  final String? rearimgPath;
  final String? frontimgPath;
  final String title;
  final Color color;
  final String takenAt;
  final String? lateCommet;
  final bool bigFont;

  const CompleteScheduledCard({
    this.rearimgPath,
    this.frontimgPath,
    required this.title,
    required this.color,
    required this.takenAt,
    this.lateCommet,
    this.bigFont = false,
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
          padding:
              rearimgPath != null && rearimgPath!.isNotEmpty
                  ? const EdgeInsets.all(1)
                  : const EdgeInsets.only(top: 5),
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: bigFont ? 30 : 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  takenAt,
                  style: TextStyle(fontSize: bigFont ? 22 : 11),
                ),
              ),
              if (lateCommet != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '일정을 놓친 이유',
                    style: TextStyle(fontSize: bigFont ? 22 : 11),
                  ),
                ),
              if (lateCommet != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AutoSizeText(
                    lateCommet!,
                    style: TextStyle(fontSize: 13),
                    minFontSize: 9,
                    maxFontSize: 13,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
