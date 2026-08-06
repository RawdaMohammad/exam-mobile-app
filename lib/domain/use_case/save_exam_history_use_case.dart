import 'package:exam_mobile_app/domain/entities/exam_history_entity.dart';
import 'package:exam_mobile_app/domain/repo/exam_history_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveExamHistoryUseCase {
  final ExamHistoryRepo _repository;

  SaveExamHistoryUseCase(this._repository);

  Future<void> call(
    ExamHistoryEntity history,
  ) {
    return _repository.saveExamHistory(history);
  }
}