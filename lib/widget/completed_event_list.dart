import 'dart:io';
import 'package:flutter/material.dart';
import '../controller/db_complete_schedule_controller.dart';
import 'package:get/get.dart';


class CompletedEventList extends StatelessWidget {
  CompletedEventList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // GetX의 RxList를 직접 구독함
      final photos = DbCompleteScheduleController.to.completeSchedules;

      // rearImgPath, frontImgPath가 모두 있는 사진만 필터링
      final validPhotos = photos.where((photo) =>
      photo.rearImgPath != null &&
          photo.rearImgPath!.isNotEmpty &&
          photo.frontImgPath != null &&
          photo.frontImgPath!.isNotEmpty).toList();

      if (validPhotos.isEmpty) {
        return SizedBox(
          height: 220,
          child: Center(
            child: Text(
              '완료한 일정이 없어요!\n오늘 하루도 힘내서 일정을 완료하세요!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        );
      }

      return SizedBox(
        height: 220,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(width: 5),
            ...validPhotos.map((photo) =>
                _ImageTile(photo.rearImgPath!, photo.frontImgPath!)),
            const SizedBox(width: 5),
          ],
        ),
      );
    });
  }

  Widget _ImageTile(String rearimgPath, String frontimgPath) {
    return Stack(
      children: [
        Container(
          width: 148,
          height: 215,
          margin: EdgeInsets.symmetric(horizontal: 5),
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
          bottom: 5,
          right: 5,
          child: Container(
            width: 56,
            height: 80,
            margin: EdgeInsets.all(5),
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
}