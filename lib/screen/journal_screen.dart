import 'package:flutter/material.dart';

class JournalScreen extends StatelessWidget{
  const JournalScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("하루 되돌아보기"),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Text('data'),
      ),
    );
  }
}