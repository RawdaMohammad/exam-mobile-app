import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/core/network/safe_call.dart';
import 'package:exam_mobile_app/data/api/exam_api_client.dart';
import 'package:exam_mobile_app/data/mapper/exam_mapper.dart';
import 'package:exam_mobile_app/domain/entities/question_entity.dart';
import 'package:exam_mobile_app/domain/repo/exam_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExamRepo)
class ExamRepoImpl implements ExamRepo {
  final ExamApiClient _examApiClient;
  final ExamMapper _examMapper;
  ExamRepoImpl(this._examApiClient, this._examMapper);
  @override
  Future<ApiResults<List<QuestionEntity>>> getExamQuestion(
    String examId,
  ) async {
    return safeCall(() async {
      var response = await _examApiClient.getExamQuestions(examId);
      return Success(
        _examMapper.mapQuestionListToEntityList(response.questions),
      );
    });
  }
}
