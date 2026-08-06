import 'package:exam_mobile_app/data/models/exam_question_response.dart';

abstract interface class ExamResultRemoteDatasource {
  Future<ExamDetailsResponse> getExam(String examId);

  Future<SubjectDetailsResponse> getSubject(String subjectId);
}