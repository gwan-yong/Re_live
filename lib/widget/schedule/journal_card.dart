import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:re_live/controller/db_journal_controller.dart';

class JournalCard extends StatelessWidget {
  JournalCard({super.key});
  final journal = DbJournalController.to.journal;

  @override
  Widget build(BuildContext context) {
    // journal.value가 null이면 아무것도 보여주지 않음
    if (journal.value == null) {
      return const SizedBox.shrink(); // 또는 SizedBox(height: 1) 등
    }

    // journal이 존재하면 실제 카드 렌더링
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3E8FF),
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('그날 느낀 점', style: TextStyle(fontSize: 25)),
          Text(
            DateFormat('a h:mm', 'ko').format(journal.value!.date),
            style: const TextStyle(fontSize: 12),
          ),
          Text(journal.value!.comment),
        ],
      ),
    );
  }
}