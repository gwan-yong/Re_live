import 'dart:io';

import 'package:flutter/material.dart';
import '../database/drift_database.dart';

class CompletedEventList extends StatelessWidget {
  CompletedEventList({super.key});

  DateTime get now => DateTime.now();

  Future<List<CompletedPhoto>> _getTodayPhotos() async {
    final db = LocalDatabase();
    return await db.getTodayPhotos(now);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CompletedPhoto>>(
      future: _getTodayPhotos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              height: 220,
              child: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return SizedBox(
              height: 220,
              child: Center(child: Text('오류 발생: ${snapshot.error}')));
        }

        final photos = snapshot.data ?? [];

        if (photos.isEmpty) {
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
              ...photos
                  .where((photo) => photo.rearImgPath != null || photo.frontImgPath != null)
                  .map((photo) =>
                  _ImageTile(photo.rearImgPath!, photo.frontImgPath!))
                  .toList(),
              const SizedBox(width: 5),
            ],
          ),
        );
      },
    );
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