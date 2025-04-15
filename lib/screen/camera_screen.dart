import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

import '../theme/colors.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  // 카메라 리스트를 가져오는 메소드
  Future<void> _initializeCamera() async {
    try {
      if (Platform.isIOS && !Platform.isMacOS && !Platform.isAndroid) {
        // 시뮬레이터에서는 카메라 기능을 사용할 수 없으므로 에러 처리
        throw 'iOS 시뮬레이터에서는 카메라를 사용할 수 없습니다.';
      }

      final cameras = await availableCameras();
      final firstCamera = cameras.first; // 첫 번째 카메라 선택

      _controller = CameraController(firstCamera, ResolutionPreset.high);

      // 카메라 초기화
      await _controller.initialize(); // initialize() 완료까지 기다림
      setState(() {
        _initializeControllerFuture = Future.value(); // 초기화가 완료되었음을 상태 갱신
      });
    } catch (e) {
      print('카메라 초기화 실패: $e');
      setState(() {
        _initializeControllerFuture = Future.error(e); // 오류 상태 갱신
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera(); // Future<void> 타입으로 수정
  }

  @override
  void dispose() {
    _controller.dispose(); // 리소스 해제
    super.dispose();
  }

  // 사진 촬영 메소드
  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture; // 카메라 초기화 대기

      final XFile picture = await _controller.takePicture(); // 사진 촬영
      print('사진 촬영 완료: ${picture.path}'); // 촬영된 사진의 경로 출력
    } catch (e) {
      print('사진 촬영 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(''), backgroundColor: Colors.white),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5),
            Text(
              "00:00",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey, //글자 색상 설정
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                //container 스타일 매개변수
                color: Colors.red, //색상 지정
                border: Border.all(
                  //테두리 설정
                  width: 3, //테두리 굵기 설정
                  color: Colors.black, //테두리 색상 설정
                ),
                borderRadius: BorderRadius.circular(
                  16, //테두리 둥글게 설정
                ),
              ),
              height: 492,
              width: 369,
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('카메라 초기화 실패: ${snapshot.error}'));
                  } else {
                    // 카메라 프리뷰를 둥글게 처리
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      // Container와 같은 radius
                      child: CameraPreview(_controller),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 50),
            Container(
              height: 95,
              width: 245,
              decoration: BoxDecoration(
                //container 스타일 매개변수
                color: secondaryColor, //색상 지정
                border: Border.all(
                  //테두리 설정
                  width: 0, //테두리 굵기 설정
                  color: secondaryColor, //테두리 색상 설정
                ),
                borderRadius: BorderRadius.circular(
                  32, //테두리 둥글게 설정
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      print("플래시 버튼 눌림!");
                    },
                    icon: Icon(Icons.flash_auto),
                  ),
                  OutlinedButton(
                    onPressed:_takePicture,
                    style: OutlinedButton.styleFrom(
                      shape: CircleBorder(),
                      // 동그란 테두리!
                      side: BorderSide(width: 6, color: Colors.white),
                      // 테두리 굵기와 색상
                      fixedSize: Size(80, 80),
                      // 버튼 크기
                      padding: EdgeInsets.zero, // 텍스트/아이콘 위치 정중앙으로 맞춤
                    ),
                    child: Text(""), // 가운데 아이콘
                  ),
                  IconButton(
                    onPressed: () {
                      print("전환 버튼 눌림!");
                    },
                    icon: Icon(Icons.cameraswitch),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
