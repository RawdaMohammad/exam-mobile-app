import 'package:exam_mobile_app/domain/entities/exam_details_entity.dart';
import 'package:exam_mobile_app/domain/repo/exam_result_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetExamUseCase {
  final ExamResultRepo _repository;

  GetExamUseCase(this._repository);

  Future<ExamDetailsEntity> call(String examId) {
    return _repository.getExam(examId);
  }
}