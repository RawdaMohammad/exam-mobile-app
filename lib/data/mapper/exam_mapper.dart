import 'package:exam_mobile_app/data/models/exam_question_response.dart';
import 'package:exam_mobile_app/domain/entities/answer_entity.dart';
import 'package:exam_mobile_app/domain/entities/question_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExamMapper {
  List<QuestionEntity> mapQuestionListToEntityList(
    List<QuestionResponse> questions,
  ) {
    return questions.map((question) => mapQuestionToEntity(question)).toList();
  }

  QuestionEntity mapQuestionToEntity(QuestionResponse question) {
    return QuestionEntity(
      id: question.id,
      question: question.question,
      answers: mapAnswerListToEntityList(question.answers),
      type: question.type,
      correct: question.correct,
    );
  }

  List<AnswerEntity> mapAnswerListToEntityList(List<AnswerResponse> answers) {
    return answers.map((answer) => mapAnswerToEntity(answer)).toList();
  }

  AnswerEntity mapAnswerToEntity(AnswerResponse answer) {
    return AnswerEntity(key: answer.key, answer: answer.answer);
  }
}
