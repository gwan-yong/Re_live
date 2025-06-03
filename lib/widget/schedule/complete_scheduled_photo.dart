import 'dart:io';

import 'package:flutter/material.dart';

class CompleteScheduledPhoto extends StatelessWidget {
  final String rearimgPath;
  final String frontimgPath;

  const CompleteScheduledPhoto({
    required this.rearimgPath,
    required this.frontimgPath,
  });

  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth ;
          double height = width * 15/13;
          return Stack(
            children: [
              Container(
                width: width,
                height: height,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(rearimgPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 5,
                child: Container(
                  width: 56,
                  height: 80,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.file(
                      File(frontimgPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}