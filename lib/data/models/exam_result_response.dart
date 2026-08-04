import 'package:exam_mobile_app/domain/entities/exam_resulr_entity.dart';

class ExamResultResponse {
  final String message;
  final int correct;
  final int wrong;
  final String total;
  final List<WrongQuestionResponse> wrongQuestions;
  final List<CorrectQuestionResponse> correctQuestions;

  const ExamResultResponse({
    required this.message,
    required this.correct,
    required this.wrong,
    required this.total,
    required this.wrongQuestions,
    required this.correctQuestions,
  });

  factory ExamResultResponse.fromJson(Map<String, dynamic> json) {
    return ExamResultResponse(
      message: json['message'] ?? '',
      correct: json['correct'] ?? 0,
      wrong: json['wrong'] ?? 0,
      total: json['total'] ?? '0%',
      wrongQuestions: (json['WrongQuestions'] as List<dynamic>? ?? [])
          .map((e) => WrongQuestionResponse.fromJson(e))
          .toList(),
      correctQuestions: (json['correctQuestions'] as List<dynamic>? ?? [])
          .map((e) => CorrectQuestionResponse.fromJson(e))
          .toList(),
    );
  }
   ExamResultEntity toEntity() {
    return ExamResultEntity(
      correct: correct,
      wrong: wrong,
      total: total,
    );
  }
}

class WrongQuestionResponse {
  final String questionId;
  final String question;
  final String incorrectAnswer;
  final String correctAnswer;
  final Map<String, dynamic> answers;

  const WrongQuestionResponse({
    required this.questionId,
    required this.question,
    required this.incorrectAnswer,
    required this.correctAnswer,
    required this.answers,
  });

  factory WrongQuestionResponse.fromJson(Map<String, dynamic> json) {
    return WrongQuestionResponse(
      questionId: json['QID'] ?? '',
      question: json['Question'] ?? '',
      incorrectAnswer: json['inCorrectAnswer'] ?? '',
      correctAnswer: json['correctAnswer'] ?? '',
      answers: Map<String, dynamic>.from(json['answers'] ?? {}),
    );
  }
}

class CorrectQuestionResponse {
  final String questionId;
  final String question;
  final String correctAnswer;
  final Map<String, dynamic> answers;

  const CorrectQuestionResponse({
    required this.questionId,
    required this.question,
    required this.correctAnswer,
    required this.answers,
  });

  factory CorrectQuestionResponse.fromJson(Map<String, dynamic> json) {
    return CorrectQuestionResponse(
      questionId: json['QID'] ?? '',
      question: json['Question'] ?? '',
      correctAnswer: json['correctAnswer'] ?? '',
      answers: Map<String, dynamic>.from(json['answers'] ?? {}),
    );
  }
}
