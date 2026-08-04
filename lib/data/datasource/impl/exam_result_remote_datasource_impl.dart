import 'package:exam_mobile_app/data/api/exam_api_client.dart';
import 'package:exam_mobile_app/data/datasource/contract/exam_result_remote_datasource.dart';
import 'package:exam_mobile_app/data/models/exam_question_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExamResultRemoteDatasource)
class ExamResultRemoteDatasourceImpl implements ExamResultRemoteDatasource {
  final ExamApiClient _apiClient;

  ExamResultRemoteDatasourceImpl(this._apiClient);

  @override
  Future<ExamDetailsResponse> getExam(String examId) {
    return _apiClient.getExam(examId);
  }

  @override
  Future<SubjectDetailsResponse> getSubject(String subjectId) {
    return _apiClient.getSubject(subjectId);
  }
}
