import 'package:exam_mobile_app/data/datasource/contract/exam_result_remote_datasource.dart';
import 'package:exam_mobile_app/domain/entities/exam_details_entity.dart';
import 'package:exam_mobile_app/domain/entities/subject_entity.dart';
import 'package:exam_mobile_app/domain/repo/exam_result_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExamResultRepo)
class ExamResultRepoImpl implements ExamResultRepo {
  final ExamResultRemoteDatasource _dataSource;

  ExamResultRepoImpl(this._dataSource);

  @override
  Future<ExamDetailsEntity> getExam(String examId) async {
    final response = await _dataSource.getExam(examId);

    return ExamDetailsEntity(
      id: response.exam.id,
      title: response.exam.title,
      duration: response.exam.duration,
      subject: response.exam.subject,
      numberOfQuestions: response.exam.numberOfQuestions,
    );
  }

  @override
  Future<SubjectEntity> getSubject(String subjectId) async {
    final response = await _dataSource.getSubject(subjectId);

    return SubjectEntity(
      id: response.subject.id,
      name: response.subject.name,
      icon: response.subject.icon,
    );
  }
}