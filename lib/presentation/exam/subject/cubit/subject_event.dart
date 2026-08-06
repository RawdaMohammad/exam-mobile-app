import 'package:exam_mobile_app/domain/entities/exam_details_entity.dart';
import 'package:exam_mobile_app/domain/entities/subject_entity.dart';

sealed class SubjectEvents {}

class LoadExams extends SubjectEvents {
  final SubjectEntity subject;

  LoadExams(this.subject);
}

class ExamClicked extends SubjectEvents {
  final SubjectEntity subject;
  final ExamDetailsEntity exam;

  ExamClicked({required this.subject, required this.exam});
}

sealed class SubjectUIEvents {}

class NavigateToExamRestrictions extends SubjectUIEvents {
  final SubjectEntity subject;
  final ExamDetailsEntity exam;

  NavigateToExamRestrictions({required this.subject, required this.exam});
}

class ShowSnackBar extends SubjectUIEvents {
  final String message;

  ShowSnackBar(this.message);
}
