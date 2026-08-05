import 'package:exam_mobile_app/data/api/exam_api_client.dart';
import 'package:exam_mobile_app/data/datasource/contract/exam_remote_datasource.dart';
import 'package:exam_mobile_app/data/models/exam_question_response.dart';
import 'package:exam_mobile_app/data/models/subjects_response.dart';
import 'package:exam_mobile_app/data/models/exam_result_response.dart';
import 'package:exam_mobile_app/data/request/submit_exam_request.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExamRemoteDatasource)
class ExamRemoteDatasourceImpl implements ExamRemoteDatasource {
  final ExamApiClient apiClient;
  ExamRemoteDatasourceImpl(this.apiClient);

  @override
  Future<ExamQuestionsResponse> getExamQuestions(String examId) {
    return apiClient.getExamQuestions(examId);
  }
  
  @override
  Future<SubjectsResponse> getSubjects() {
    return apiClient.getSubjects();
  }

  @override
  Future<ExamResultResponse> submitExam(SubmitExamRequest request) {
    return apiClient.submitExam(request);
  }
}
