import 'dart:io';
import 'package:flutter/material.dart';
import '../../controller/db_complete_schedule_controller.dart';
import 'package:intl/intl.dart';

class CompletedScheduledListItems {
  static List<Widget> build() {
    final photos = DbCompleteScheduleController.to.completeSchedules;

    if (photos.isEmpty) {
      return const [];
    }

    // rearImgPath, frontImgPath가 모두 있는 사진만 필터링
    final validPhotos = photos.where((photo) =>
    photo.rearImgPath != null &&
        photo.rearImgPath!.isNotEmpty &&
        photo.frontImgPath != null &&
        photo.frontImgPath!.isNotEmpty).toList();

    return [

      ...validPhotos.map((photo) => _ImageTile(photo.rearImgPath!, photo.frontImgPath!,DateFormat('a h:mm', 'ko').format(photo.takenAt!))),

    ];
  }

  static Widget _ImageTile(String rearimgPath, String frontimgPath, String takenAt) {
    return LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth ;
          double height = width * 15/13;
          double postion = constraints.maxHeight/4 +5;
          print('사진폭 :${width}');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: width,
                    height: height,
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.file(
                        File(rearimgPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: postion,
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                child: Text('테스트 일정' ,style: const TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(takenAt),
              ),

            ],
          );
        }
    );
  }
}