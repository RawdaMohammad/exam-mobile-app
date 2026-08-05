import 'package:hive_flutter/hive_flutter.dart';
import 'package:exam_mobile_app/data/models/exam_history.dart';
import 'package:exam_mobile_app/data/models/exam_history_adapter.dart';
import 'package:exam_mobile_app/data/models/attempted_question_adapter.dart';

abstract class HiveConfig {
  static const String examHistoryBox = 'exam_history_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ExamHistoryAdapter());
    Hive.registerAdapter(AttemptedQuestionAdapter());

    await Hive.openBox<ExamHistory>(examHistoryBox);
  }
}