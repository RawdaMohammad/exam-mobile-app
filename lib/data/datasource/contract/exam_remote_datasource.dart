import 'package:exam_mobile_app/data/models/exam_question_response.dart';
import 'package:exam_mobile_app/data/models/exam_result_response.dart';
import 'package:exam_mobile_app/data/request/submit_exam_request.dart';

abstract interface class ExamRemoteDatasource {
  Future<ExamQuestionsResponse> getExamQuestions(String examId);

  Future<ExamResultResponse> submitExam(SubmitExamRequest request);
}
