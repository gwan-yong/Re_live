import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget{
  const EventScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("신규일정"),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Text('data'),
      ),
    );
  }
}