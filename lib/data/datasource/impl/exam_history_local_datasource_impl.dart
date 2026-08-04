import 'package:exam_mobile_app/core/local/hive/hive_config.dart';
import 'package:exam_mobile_app/data/datasource/contract/exam_history_local_datasource.dart';
import 'package:exam_mobile_app/data/models/exam_history.dart';
import 'package:exam_mobile_app/domain/entities/exam_history_entity.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExamHistoryLocalDatasource)
class ExamHistoryLocalDataSourceImpl implements ExamHistoryLocalDatasource {
  final Box<ExamHistory> _box;

  ExamHistoryLocalDataSourceImpl()
    : _box = Hive.box<ExamHistory>(HiveConfig.examHistoryBox);
  @override
  Future<void> saveExamHistory(ExamHistoryEntity history) async {
    final model = ExamHistory(
      examId: history.examId,
      subjectId: history.subjectId,
      questionCount: history.questionCount,
      timeTaken: history.timeTaken,
      attemptedAt: history.attemptedAt,
      questions: history.questions
          .map(
            (question) => AttemptedQuestion(
              questionId: question.questionId,
              question: question.question,
              userAnswer: question.userAnswer,
              isCorrect: question.isCorrect,
            ),
          )
          .toList(),
    );

    await _box.put(history.examId, model);
  }

  @override
  Future<List<ExamHistoryEntity>> getExamHistory() async {
    return _box.values.map((history) {
      return ExamHistoryEntity(
        examId: history.examId,
        subjectId: history.subjectId,
        questionCount: history.questionCount,
        timeTaken: history.timeTaken,
        attemptedAt: history.attemptedAt,
        questions: history.questions
            .map(
              (question) => AttemptedQuestionEntity(
                questionId: question.questionId,
                question: question.question,
                userAnswer: question.userAnswer,
                isCorrect: question.isCorrect,
              ),
            )
            .toList(),
      );
    }).toList();
  }

  @override
  Future<void> clearExamHistory() async {
    await _box.clear();
  }
}
