import 'package:exam_mobile_app/data/models/exam_list_response.dart';
import 'package:exam_mobile_app/data/models/exam_question_response.dart';
import 'package:exam_mobile_app/data/models/subjects_response.dart';
import 'package:exam_mobile_app/data/models/exam_result_response.dart';
import 'package:exam_mobile_app/data/request/submit_exam_request.dart';

abstract interface class ExamRemoteDatasource {
  Future<ExamQuestionsResponse> getExamQuestions(String examId);

  Future<SubjectsResponse> getSubjects();

  Future<ExamResultResponse> submitExam(SubmitExamRequest request);

  Future<ExamListResponse> getExamsBySubject(String subjectId);
}
