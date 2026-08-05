import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/domain/entities/subject_entity.dart';
import 'package:exam_mobile_app/domain/repo/exam_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubjectsUseCase {
  final ExamRepo _examRepo;
  const GetSubjectsUseCase(this._examRepo);

  Future<ApiResults<List<SubjectEntity>>> call() => _examRepo.getSubjects();
}
