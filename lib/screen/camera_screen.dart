/*
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../controller/select_schedule_controller.dart';
import '../theme/colors.dart';
import 'photos_upload_screen.dart';

class CameraScreen extends StatefulWidget {
  final bool fromMissedEvent;

  const CameraScreen({Key? key, this.fromMissedEvent = false}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with SingleTickerProviderStateMixin{
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> _cameras;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;


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

    // 애니메이션 컨트롤러 초기화
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // 슬라이드 애니메이션 설정 (위에서 아래로)
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

  }

  @override
  void dispose() {
    _animationController.dispose();
    try {
      _controller?.dispose();
    } catch (e) {
      print('dispose 중 오류 발생: $e');
    }
    super.dispose();
  }
  void _closeCameraScreen() async {
    await _animationController.forward();
    Navigator.of(context).pop();
  }

  */
/*Future<void> _takePicture() async {
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
  }*/
/*


  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      if (_controller == null || !_controller!.value.isInitialized) {
        throw Exception('카메라 컨트롤러 미초기화');
      }

      // ✅ 카메라가 정상 작동하는 경우
      final XFile picture = await _controller!.takePicture();
      print('사진 $_pictureCount 촬영 완료: ${picture.path}');

      if (_pictureCount == 0) {
        _rearImagePath = picture.path;
        _pictureCount++;
        _initializeControllerFuture = _initializeCamera(useFrontCamera: true);
      } else if (_pictureCount == 1) {
        _frontImagePath = picture.path;
        _navigateToResultScreen();
      }
    } catch (e) {
      print('사진 촬영 실패 or 카메라 미초기화: $e');

      // ❌ 카메라 초기화 실패: 샘플 이미지로 대체
      if (_pictureCount == 0) {
        final rearFile = await copyAssetToFile('assets/img/sample4.jpeg', 'rear_temp.jpeg');
        _rearImagePath = rearFile.path;
        _pictureCount++;
      } else if (_pictureCount == 1) {
        final frontFile = await copyAssetToFile('assets/img/sample1.jpeg', 'front_temp.jpeg');
        _frontImagePath = frontFile.path;
        _navigateToResultScreen();
      }
    }
  }

  void _navigateToResultScreen() {
    if (widget.fromMissedEvent) {
      Navigator.pop(context, {
        'rearImagePath': _rearImagePath!,
        'frontImagePath': _frontImagePath!,
      });
    } else {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 5),
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
                Align(
                  alignment: Alignment.topCenter,
                  child: IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down, size: 32),
                    onPressed: _closeCameraScreen,
                  ),
                ),
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
                      */
/*OutlinedButton(
                        onPressed: () async {
                          try {
                            await _initializeControllerFuture;

                            if (_controller == null || !_controller!.value.isInitialized) {
                              throw Exception("카메라 컨트롤러 미초기화");
                            }

                            // ✅ 카메라가 정상 작동하는 경우
                            await _takePicture();
                          } catch (e) {
                            // ❌ 초기화 실패: 샘플 이미지로 이동
                            final rearFile = await copyAssetToFile('assets/img/sample4.jpeg', 'rear_temp.jpeg');
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
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          shape: CircleBorder(),
                          side: BorderSide(width: 6, color: Colors.white),
                          fixedSize: Size(80, 80),
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(""),
                      ),*/
/*

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
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../controller/select_schedule_controller.dart';
import '../theme/colors.dart';
import 'photos_upload_screen.dart';

class CameraScreen extends StatefulWidget {
  final bool fromMissedEvent;

  const CameraScreen({Key? key, this.fromMissedEvent = false}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with SingleTickerProviderStateMixin {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> _cameras;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  int _pictureCount = 0;
  String? _rearImagePath;
  String? _frontImagePath;

  bool _cameraInitFailed = false;
  int _mockPreviewStep = 0; // 0: sample4, 1: sample1

  Future<void> _initializeCamera({bool useFrontCamera = false}) async {
    try {
      _cameras = await availableCameras();

      final selectedCamera = useFrontCamera
          ? _cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front)
          : _cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);

      _controller = CameraController(selectedCamera, ResolutionPreset.high);

      await _controller!.initialize();

      setState(() {
        _cameraInitFailed = false;
        _initializeControllerFuture = Future.value();
      });
    } catch (e) {
      print('카메라 초기화 실패: $e');
      setState(() {
        _initializeControllerFuture = Future.error(e);
        _controller = null;
        _cameraInitFailed = true;
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

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    try {
      _controller?.dispose();
    } catch (e) {
      print('dispose 중 오류 발생: $e');
    }
    super.dispose();
  }

  void _closeCameraScreen() async {
    await _animationController.forward();
    Navigator.of(context).pop();
  }

  Future<void> _takePicture() async {
    if (_cameraInitFailed) {
      if (_pictureCount == 0) {
        final rearFile = await copyAssetToFile('assets/img/sample4.jpeg', 'rear_temp.jpeg');
        _rearImagePath = rearFile.path;
        _pictureCount++;
        setState(() => _mockPreviewStep = 1);
      } else if (_pictureCount == 1) {
        final frontFile = await copyAssetToFile('assets/img/sample1.jpeg', 'front_temp.jpeg');
        _frontImagePath = frontFile.path;
        _navigateToResultScreen();
      }
      return;
    }

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
        _initializeControllerFuture = _initializeCamera(useFrontCamera: true);
      } else if (_pictureCount == 1) {
        _frontImagePath = picture.path;
        _navigateToResultScreen();
      }
    } catch (e) {
      print('사진 촬영 실패: $e');
    }
  }

  void _navigateToResultScreen() {
    if (widget.fromMissedEvent) {
      Navigator.pop(context, {
        'rearImagePath': _rearImagePath!,
        'frontImagePath': _frontImagePath!,
      });
    } else {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 5),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.circular(16),
                ),
                height: 492,
                width: 369,
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (_cameraInitFailed) {
                      final sampleAsset = _mockPreviewStep == 0
                          ? 'assets/img/sample4.jpeg'
                          : 'assets/img/sample1.jpeg';
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(sampleAsset, fit: BoxFit.cover),
                      );
                    } else if (snapshot.hasError || _controller == null) {
                      return const Center(child: Text('카메라 오류'));
                    } else {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CameraPreview(_controller!),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.topCenter,
                child: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down, size: 32),
                  onPressed: _closeCameraScreen,
                ),
              ),
              Container(
                height: 95,
                width: 245,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: _takePicture,
                      style: OutlinedButton.styleFrom(
                        shape: const CircleBorder(),
                        side: const BorderSide(width: 6, color: Colors.white),
                        fixedSize: const Size(80, 80),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(""),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}