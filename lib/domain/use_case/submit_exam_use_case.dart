import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/data/request/submit_exam_request.dart';
import 'package:exam_mobile_app/domain/entities/exam_resulr_entity.dart';
import 'package:exam_mobile_app/domain/repo/exam_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubmitExamUseCase {
  final ExamRepo _repository;

  SubmitExamUseCase(this._repository);

  Future<ApiResults<ExamResultEntity>> call(
    SubmitExamRequest request,
  ) {
    return _repository.submitExam(request);
  }
}