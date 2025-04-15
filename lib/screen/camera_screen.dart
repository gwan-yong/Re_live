import 'package:flutter/material.dart';

class CameraScreen extends StatelessWidget{
  const CameraScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("카메라"),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Text('data'),
      ),
    );
  }
}