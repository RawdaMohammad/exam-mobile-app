import 'package:exam_mobile_app/domain/entities/exam_history_entity.dart';

abstract interface class ExamHistoryRepo {
  Future<void> saveExamHistory(
    ExamHistoryEntity history,
  );

  Future<List<ExamHistoryEntity>> getExamHistory();

  Future<void> clearExamHistory();
}