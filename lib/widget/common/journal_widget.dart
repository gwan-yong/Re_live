import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_live/controller/db_journal_controller.dart';
import 'package:re_live/database/drift_database.dart';
import '../../controller/card_carousel_controller.dart';
import '../../controller/select_schedule_controller.dart';
import '../../theme/colors.dart';


class JournalWidget extends StatelessWidget {

  final VoidCallback? onSubmit; // 등록 후 콜백
  JournalWidget({super.key, this.onSubmit});

  final TextEditingController _CommentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final nowJournal = DbJournalController.to.journal.value;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: double.infinity,
          height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 4,
                color: secondaryColor,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                    '오늘 하루의 대한 감상평'
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: TextField(
                  controller: _CommentController,
                  onTapOutside:
                      (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  minLines: 5,
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
              GestureDetector(
                onTap: () async {
                  final newJournal = JournalCompanion(
                    date: drift.Value(DateTime.now()),
                    comment: drift.Value(
                      _CommentController.text.trim(),
                    ),
                  );
                  await DbJournalController.to.updateJourna(
                      SelectScheduleController.to.selectDate.value,
                      newJournal
                  );
                  CardCarouselController.to.loadItems(context);

                  onSubmit?.call();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(child: Text('등록')),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}