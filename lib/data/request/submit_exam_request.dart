class SubmitExamRequest {
  final List<ExamAnswerRequest> answers;
  final int time;

  const SubmitExamRequest({
    required this.answers,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        'answers': answers.map((e) => e.toJson()).toList(),
        'time': time,
      };
}

class ExamAnswerRequest {
  final String questionId;
  final String correct;

  const ExamAnswerRequest({
    required this.questionId,
    required this.correct,
  });

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'correct': correct,
      };
}