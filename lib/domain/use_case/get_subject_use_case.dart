import 'package:exam_mobile_app/domain/entities/subject_details_entity.dart';
import 'package:exam_mobile_app/domain/repo/exam_result_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubjectUseCase {
  final ExamResultRepo _repository;

  GetSubjectUseCase(this._repository);

  Future<SubjectDetailsEntity> call(String subjectId) {
    return _repository.getSubject(subjectId);
  }
}