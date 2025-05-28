import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:re_live/theme/colors.dart';
import 'package:re_live/widget/schedule/missed_scheduled_list.dart';
import '../controller/db_journal_controller.dart';
import '../database/drift_database.dart';
import '../widget/schedule/completed_scheduled_list.dart';
import 'home_screen.dart';

class JournalScreen extends StatelessWidget{
  JournalScreen({super.key});

  String comment = '';

  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("하루 되돌아보기"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                      '오늘 진행된 일정'
                  ),
                ),
                CompletedScheduledList(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                      '소화하지 못한 일정'
                  ),
                ),
                MissedScheduledList(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                      '오늘 하루의 대한 감상평'
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                    onChanged: (value) {
                      comment = value;
                    },
                    minLines: 3,
                    maxLines: null,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: secondaryColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "코멘트...",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () async{
                      final newJournal = JournalCompanion(
                        date : drift.Value(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day)),
                        comment : drift.Value(comment),
                      );
                      await DbJournalController.to.addJournal(newJournal);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen())
                      );
                    },
                    child:
                    Container(
                      width: 348,
                      height: 50,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(child: Text('등록')),
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}

