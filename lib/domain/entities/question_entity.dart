import 'package:exam_mobile_app/domain/entities/answer_entity.dart';

class QuestionEntity {
  final String? id;
  final String? question;
  final List<AnswerEntity>? answers;
  final String? type;
  final String? correct;

  const QuestionEntity({
    required this.id,
    required this.question,
    required this.answers,
    required this.type,
    required this.correct,
  });
}