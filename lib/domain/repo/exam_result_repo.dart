import 'package:exam_mobile_app/domain/entities/exam_details_entity.dart';
import 'package:exam_mobile_app/domain/entities/subject_details_entity.dart';

abstract class ExamResultRepo {
  Future<ExamDetailsEntity> getExam(String examId);

  Future<SubjectDetailsEntity> getSubject(String subjectId);
}