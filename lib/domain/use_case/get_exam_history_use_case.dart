import 'package:exam_mobile_app/domain/entities/exam_history_entity.dart';
import 'package:exam_mobile_app/domain/repo/exam_history_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetExamHistoryUseCase {
  final ExamHistoryRepo _repository;

  GetExamHistoryUseCase(this._repository);

  Future<List<ExamHistoryEntity>> call() {
    return _repository.getExamHistory();
  }
}