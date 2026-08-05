import 'package:exam_mobile_app/core/local/hive/hive_config.dart';
import 'package:exam_mobile_app/data/models/exam_history.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HiveModule {
  @singleton
  Box<ExamHistory> provideExamHistoryBox() {
    return Hive.box<ExamHistory>(HiveConfig.examHistoryBox);
  }
}