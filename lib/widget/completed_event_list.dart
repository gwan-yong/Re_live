import 'package:flutter/material.dart';

class CompletedEventList extends StatelessWidget{
  Widget build(BuildContext context){
    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal, // 가로 스크롤
        children: [
          const SizedBox(width: 5),
          _ImageTile("assets/img/sample2.jpeg", "assets/img/sample1.jpeg"),
          _ImageTile("assets/img/sample4.jpeg", "assets/img/sample3.jpeg"),
          _ImageTile("assets/img/sample5.jpeg", "assets/img/sample6.jpeg"),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  Widget _ImageTile(String rearimgPath, String frontimgPath){
    return Stack(
        children: [
          Container(
            width: 148,
            height: 215,
            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 0),
            decoration: BoxDecoration(
              border: Border.all( // 테두리 설정
                color: Colors.black, // 테두리 색상
                width: 3, // 테두리 두께
              ),
              borderRadius: BorderRadius.circular(16), // 테두리 둥글게 만들기
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13), // 테두리 둥글게
              child: Image.asset(
                rearimgPath,
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
          ),
          Positioned(
            bottom: 5, //하단에서 5만큼 떨어진 위치
            right: 5, //우측에서 5만큼 떨어진 위치
            child: Container(
              width: 56,
              height: 80,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all( // 테두리 설정
                  color: Colors.black, // 테두리 색상
                  width: 3, // 테두리 두께
                ),
                borderRadius: BorderRadius.circular(16), // 테두리 둥글게 만들기
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13), // 테두리 둥글게
                child: Image.asset(
                  frontimgPath,
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              ),
            ),
          ),
        ]
    );
  }
}