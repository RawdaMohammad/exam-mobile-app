import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/domain/entities/exam_details_entity.dart';
import 'package:exam_mobile_app/domain/repo/exam_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetExamsBySubjectUseCase {
  final ExamRepo _examRepo;

  GetExamsBySubjectUseCase(this._examRepo);

  Future<ApiResults<List<ExamDetailsEntity>>> call(String subjectId) {
    return _examRepo.getExamsBySubject(subjectId);
  }
}
