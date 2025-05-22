import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../theme/colors.dart';
import 'photos_upload_screen.dart';

class CameraScreen extends StatefulWidget {
  final bool fromMissedEvent;

  const CameraScreen({Key? key, this.fromMissedEvent = false}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
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
        _initializeControllerFuture = Future.value();
      });
    } catch (e) {
      print('카메라 초기화 실패: $e');
      setState(() {
        _initializeControllerFuture = Future.error(e);
        _controller = null;
      });
    }
  }

  Future<File> copyAssetToFile(String assetPath, String filename) async {
    final byteData = await rootBundle.load(assetPath);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$filename');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera(useFrontCamera: false);
  }

  @override
  void dispose() {
    try {
      _controller?.dispose();
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

        if (widget.fromMissedEvent) {
          // MissedEventJournal로부터 왔다면 pop으로 결과 전달
          Navigator.pop(context, {
            'rearImagePath': _rearImagePath!,
            'frontImagePath': _frontImagePath!,
          });
        } else {
          // 일반적으로 PhotosUploadScreen으로 이동
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
              "00:00", // 추후 타이머 표시 가능
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

                      if (widget.fromMissedEvent) {
                        Navigator.pop(context, {
                          'rearImagePath': rearFile.path,
                          'frontImagePath': frontFile.path,
                        });
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhotosUploadScreen(
                              rearImagePath: rearFile.path,
                              frontImagePath: frontFile.path,
                            ),
                          ),
                        );
                      }
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