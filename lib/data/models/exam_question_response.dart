class ExamQuestionsResponse {
  final String message;
  final List<QuestionResponse> questions;

  const ExamQuestionsResponse({
    required this.message,
    required this.questions,
  });

  factory ExamQuestionsResponse.fromJson(Map<String, dynamic> json) {
    return ExamQuestionsResponse(
      message: json['message'] ?? '',
      questions: (json['questions'] as List<dynamic>? ?? [])
          .map((e) => QuestionResponse.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'questions': questions.map((e) => e.toJson()).toList(),
      };
}

class QuestionResponse {
  final String id;
  final String question;
  final List<AnswerResponse> answers;
  final String type;
  final String correct;
  final DateTime createdAt;

  const QuestionResponse({
    required this.id,
    required this.question,
    required this.answers,
    required this.type,
    required this.correct,
    required this.createdAt,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuestionResponse(
      id: json['_id'] ?? '',
      question: json['question'] ?? '',
      answers: (json['answers'] as List<dynamic>? ?? [])
          .map((e) => AnswerResponse.fromJson(e))
          .toList(),
      type: json['type'] ?? '',
      correct: json['correct'] ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'question': question,
        'answers': answers.map((e) => e.toJson()).toList(),
        'type': type,
        'correct': correct,
        'createdAt': createdAt.toIso8601String(),
      };

  bool get isSingleChoice => type == 'single_choice';

  bool get isMultipleChoice => type == 'multiple_choice';
}

class AnswerResponse {
  final String key;
  final String answer;

  const AnswerResponse({
    required this.key,
    required this.answer,
  });

  factory AnswerResponse.fromJson(Map<String, dynamic> json) {
    return AnswerResponse(
      key: json['key'] ?? '',
      answer: json['answer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'answer': answer,
      };
}