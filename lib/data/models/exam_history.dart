class ExamHistory {
  final String examId;
  final String subjectId;
  final int questionCount;
  final int timeTaken;
  final DateTime attemptedAt;
  final List<AttemptedQuestion> questions;

  const ExamHistory({
    required this.examId,
    required this.subjectId,
    required this.questionCount,
    required this.timeTaken,
    required this.attemptedAt,
    required this.questions,
  });
}

class AttemptedQuestion {
  final String questionId;
  final String question;
  final String userAnswer;
  final bool isCorrect;

  const AttemptedQuestion({
    required this.questionId,
    required this.question,
    required this.userAnswer,
    required this.isCorrect,
  });
}
