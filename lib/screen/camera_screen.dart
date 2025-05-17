import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../theme/colors.dart';
import 'photos_upload_screen.dart'; // 사진 업로드 화면 import

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller; // late 제거하고 nullable로 변경
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> _cameras;

  int _pictureCount = 0;
  String? _rearImagePath;
  String? _frontImagePath;

  Future<void> _initializeCamera({bool useFrontCamera = false}) async {
    try {
      _cameras = await availableCameras();

      final selectedCamera = useFrontCamera
          ? _cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front)
          : _cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);

      _controller = CameraController(selectedCamera, ResolutionPreset.high);

      await _controller!.initialize();

      setState(() {
        _initializeControllerFuture = Future.value(); // 초기화 완료 표시
      });
    } catch (e) {
      print('카메라 초기화 실패: $e');
      setState(() {
        _initializeControllerFuture = Future.error(e); // 에러를 Future로 전달
        _controller = null;
      });
    }
  }

  Future<File> copyAssetToFile(String assetPath, String filename) async {
    // 에셋을 메모리에 로드
    final byteData = await rootBundle.load(assetPath);

    // 임시 디렉토리 가져오기
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$filename');

    // 에셋 데이터를 파일로 복사
    await file.writeAsBytes(byteData.buffer.asUint8List());

    return file; // FileImage로 사용 가능
  }


  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera(useFrontCamera: false);
  }

  @override
  void dispose() {
    try {
      _controller?.dispose(); // null일 수 있으므로 안전하게
    } catch (e) {
      print('dispose 중 오류 발생: $e');
    }
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      if (_controller == null || !_controller!.value.isInitialized) {
        print('카메라 컨트롤러가 초기화되지 않음');
        return;
      }

      final XFile picture = await _controller!.takePicture();
      print('사진 $_pictureCount 촬영 완료: ${picture.path}');

      if (_pictureCount == 0) {
        _rearImagePath = picture.path;
        _pictureCount++;

        // 전면 카메라로 전환
        _initializeControllerFuture = _initializeCamera(useFrontCamera: true);

      } else if (_pictureCount == 1) {
        _frontImagePath = picture.path;

        // 화면 이동 및 경로 전달
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PhotosUploadScreen(
              rearImagePath: _rearImagePath!,
              frontImagePath: _frontImagePath!,
            ),
          ),
        );
      }
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
              "00:00", // 타이머 또는 시간 추후 구현 가능
              style: TextStyle(fontSize: 20.0, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(width: 3, color: Colors.black),
                borderRadius: BorderRadius.circular(16),
              ),
              height: 492,
              width: 369,
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || _controller == null) {
                    return Center(child: Text('카메라 초기화 실패'));
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CameraPreview(_controller!),
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
                color: secondaryColor,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      final rearFile = await copyAssetToFile('assets/img/sample2.jpeg', 'rear_temp.jpeg');
                      final frontFile = await copyAssetToFile('assets/img/sample1.jpeg', 'front_temp.jpeg');

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotosUploadScreen(
                            rearImagePath: rearFile.path,
                            frontImagePath: frontFile.path,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.cameraswitch),
                  ),
                  OutlinedButton(
                    onPressed: _takePicture,
                    style: OutlinedButton.styleFrom(
                      shape: CircleBorder(),
                      side: BorderSide(width: 6, color: Colors.white),
                      fixedSize: Size(80, 80),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(""),
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