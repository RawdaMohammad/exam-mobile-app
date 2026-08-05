import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/core/network/safe_call.dart';
import 'package:exam_mobile_app/data/api/exam_api_client.dart';
import 'package:exam_mobile_app/data/datasource/contract/exam_remote_datasource.dart';
import 'package:exam_mobile_app/data/mapper/exam_mapper.dart';
import 'package:exam_mobile_app/data/request/submit_exam_request.dart';
import 'package:exam_mobile_app/domain/entities/exam_resulr_entity.dart';
import 'package:exam_mobile_app/domain/entities/question_entity.dart';
import 'package:exam_mobile_app/domain/entities/subject_entity.dart';
import 'package:exam_mobile_app/domain/repo/exam_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExamRepo)
class ExamRepoImpl implements ExamRepo {
  final ExamMapper _examMapper;
  final ExamRemoteDatasource _examRemoteDatasource;

  ExamRepoImpl(this._examMapper,this._examRemoteDatasource);
  @override
  Future<ApiResults<List<QuestionEntity>>> getExamQuestion(
    String examId,
  ) async {
    return safeCall(() async {
      var response = await _examRemoteDatasource.getExamQuestions(examId);
      return Success(
        _examMapper.mapQuestionListToEntityList(response.questions),
      );
    });
  }

  @override
  Future<ApiResults<ExamResultEntity>> submitExam(SubmitExamRequest request) {
    return safeCall(() async {
      final response = await _examRemoteDatasource.submitExam(request);
      return Success(response.toEntity());
    });
  }
  @override
  Future<ApiResults<List<SubjectEntity>>> getSubjects() {
    return safeCall(() async {
      final response = await _examRemoteDatasource.getSubjects();
      return Success(
        _examMapper.subjectResponseListToSubjectEntityList(response.subjects ?? []),
      );
    });
  }
}
