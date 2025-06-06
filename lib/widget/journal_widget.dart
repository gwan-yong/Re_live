import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_live/controller/db_journal_controller.dart';

import '../theme/colors.dart';
import 'schedule/completed_scheduled_list_items.dart';


class JournalWidget extends StatelessWidget {
  const JournalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final journal = DbJournalController.to.journal.value;

      if (journal == null) {
        return const Center(child: Text('기록된 일정이 없습니다.'));
      }else{
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                    '오늘 진행된 일정'
                ),
              ),
              //CompletedScheduledList(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                    '오늘 하루의 대한 감상평'
                ),
              ),
              Container(
                width: 348,
                height: 50,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child:Text(
                    "${DbJournalController.to.journal.value!.comment}"
                ),
              ),
            ],
          ),
        );
      }

    });
  }
}