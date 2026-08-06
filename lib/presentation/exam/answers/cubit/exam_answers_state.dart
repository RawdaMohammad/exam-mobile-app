import 'package:exam_mobile_app/domain/entities/exam_history_entity.dart';
import 'package:exam_mobile_app/domain/entities/question_entity.dart';

class ExamAnswersState {
  final List<QuestionEntity> questions;
  final ExamHistoryEntity? history;
  final bool isLoading;
  final String? errorMessage;

  const ExamAnswersState({
    required this.questions,
    required this.history,
    required this.isLoading,
    required this.errorMessage,
  });

  ExamAnswersState.initial()
    : this(questions: [], history: null, isLoading: false, errorMessage: null);

  ExamAnswersState copyWith({
    List<QuestionEntity>? questions,
    ExamHistoryEntity? history,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ExamAnswersState(
      questions: questions ?? this.questions,
      history: history ?? this.history,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
