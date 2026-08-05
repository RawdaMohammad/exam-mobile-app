import 'package:exam_mobile_app/domain/entities/exam_details_entity.dart';
import 'package:exam_mobile_app/domain/entities/subject_entity.dart';

abstract interface class ExamResultRepo {
  Future<ExamDetailsEntity> getExam(String examId);

  Future<SubjectEntity> getSubject(String subjectId);
}