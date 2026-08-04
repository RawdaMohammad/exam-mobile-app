sealed class ExamAnswersEvent {
  const ExamAnswersEvent();
}

class LoadExamAnswers extends ExamAnswersEvent {
  final String examId;

  const LoadExamAnswers(this.examId);
}
