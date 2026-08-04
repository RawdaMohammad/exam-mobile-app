import 'package:exam_mobile_app/data/models/exam_question_response.dart';

abstract class ExamRemoteDatasource {
  Future<ExamQuestionsResponse> getExamQuestions(String examId);
}
