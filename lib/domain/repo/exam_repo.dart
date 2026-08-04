import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/domain/entities/question_entity.dart';

abstract class ExamRepo {
  Future<ApiResults<List<QuestionEntity>>> getExamQuestion(String examId);
}
