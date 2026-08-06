sealed class ExamResultsEvent {}

class LoadExamResults extends ExamResultsEvent {}

class OpenExamAnswers extends ExamResultsEvent {
  final String examId;

  OpenExamAnswers(this.examId);
}

sealed class ExamResultsUIEvent {}

class NavigateToExamAnswers extends ExamResultsUIEvent {
  final String examId;
  NavigateToExamAnswers(this.examId);
}
