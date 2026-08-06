import 'package:exam_mobile_app/domain/entities/exam_history_entity.dart';

abstract interface class ExamHistoryLocalDatasource {
  Future<void> saveExamHistory(ExamHistoryEntity examHistory);

  Future<List<ExamHistoryEntity>> getExamHistory();

  Future<void> clearExamHistory();
}
