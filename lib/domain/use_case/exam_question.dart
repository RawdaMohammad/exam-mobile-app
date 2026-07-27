import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/domain/entities/question_entity.dart';
import 'package:exam_mobile_app/domain/repo/exam_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExamQuestion {
  final ExamRepo _repository;
  ExamQuestion(this._repository);

  Future<ApiResults<List<QuestionEntity>>> call(String examId) {
    return _repository.getExamQuestion(examId);
  }
}
