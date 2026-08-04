import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/data/request/submit_exam_request.dart';
import 'package:exam_mobile_app/domain/entities/exam_resulr_entity.dart';
import 'package:exam_mobile_app/domain/entities/question_entity.dart';

abstract class ExamRepo {
  Future<ApiResults<List<QuestionEntity>>> getExamQuestion(String examId);

  Future<ApiResults<ExamResultEntity>> submitExam(SubmitExamRequest request);
}
