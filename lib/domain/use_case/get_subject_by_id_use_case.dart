import 'package:exam_mobile_app/domain/entities/subject_entity.dart';
import 'package:exam_mobile_app/domain/repo/exam_result_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubjectByIdUseCase {
  final ExamResultRepo _repository;

  GetSubjectByIdUseCase(this._repository);

  Future<SubjectEntity> call(String subjectId) {
    return _repository.getSubject(subjectId);
  }
}