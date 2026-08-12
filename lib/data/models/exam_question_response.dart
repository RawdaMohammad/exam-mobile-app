class ExamQuestionsResponse {
  final String message;
  final List<QuestionResponse> questions;

  const ExamQuestionsResponse({required this.message, required this.questions});

  factory ExamQuestionsResponse.fromJson(Map<String, dynamic> json) {
    return ExamQuestionsResponse(
      message: json['message'] ?? '',
      questions: (json['questions'] as List<dynamic>? ?? [])
          .map((e) => QuestionResponse.fromJson(e as Map<String, dynamic>))
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
  final ExamResponse exam;
  final SubjectResponse subject;

  const QuestionResponse({
    required this.id,
    required this.question,
    required this.answers,
    required this.type,
    required this.correct,
    required this.createdAt,
    required this.exam,
    required this.subject,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuestionResponse(
      id: json['_id'] ?? '',
      question: json['question'] ?? '',
      answers: (json['answers'] as List<dynamic>? ?? [])
          .map((e) => AnswerResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] ?? '',
      correct: json['correct'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),

      exam: ExamResponse.fromJson(json['exam'] as Map<String, dynamic>? ?? {}),

      subject: SubjectResponse.fromJson(
        json['subject'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'question': question,
    'answers': answers.map((e) => e.toJson()).toList(),
    'type': type,
    'correct': correct,
    'createdAt': createdAt.toIso8601String(),
    'exam': exam.toJson(),
    'subject': subject.toJson(),
  };

  List<String> get correctAnswers {
    return correct
        .split(',')
        .map((answer) => answer.trim())
        .where((answer) => answer.isNotEmpty)
        .toList();
  }

  bool get isSingleChoice => type == 'single_choice';

  bool get isMultipleChoice => type == 'multiple_choice';
}

class AnswerResponse {
  final String key;
  final String answer;

  const AnswerResponse({required this.key, required this.answer});

  factory AnswerResponse.fromJson(Map<String, dynamic> json) {
    return AnswerResponse(key: json['key'] ?? '', answer: json['answer'] ?? '');
  }

  Map<String, dynamic> toJson() => {'key': key, 'answer': answer};
}

class ExamDetailsResponse {
  final String message;
  final ExamResponse exam;

  const ExamDetailsResponse({
    required this.message,
    required this.exam,
  });

  factory ExamDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ExamDetailsResponse(
      message: json['message'] ?? '',
      exam: ExamResponse.fromJson(
        json['exam'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}
class ExamResponse {
  final String id;
  final String title;
  final int duration;
  final String subject;
  final int numberOfQuestions;

  const ExamResponse({
    required this.id,
    required this.title,
    required this.duration,
    required this.subject,
    required this.numberOfQuestions,
  });

  factory ExamResponse.fromJson(Map<String, dynamic> json) {
    return ExamResponse(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      duration: json['duration'] ?? 0,
      subject: json['subject'] ?? '',
      numberOfQuestions: json['numberOfQuestions'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'title': title,
    'duration': duration,
    'subject': subject,
    'numberOfQuestions': numberOfQuestions,
  };
}

class SubjectResponse {
  final String id;
  final String name;
  final String icon;

  const SubjectResponse({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory SubjectResponse.fromJson(Map<String, dynamic> json) {
    return SubjectResponse(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'_id': id, 'name': name, 'icon': icon};
}


class SubjectDetailsResponse {
  final String message;
  final SubjectResponse subject;

  const SubjectDetailsResponse({
    required this.message,
    required this.subject,
  });

  factory SubjectDetailsResponse.fromJson(Map<String, dynamic> json) {
    return SubjectDetailsResponse(
      message: json['message'] ?? '',
      subject: SubjectResponse.fromJson(
        json['category'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}
