import 'package:exam_mobile_app/domain/use_case/exam_question_use_case.dart';
import 'package:exam_mobile_app/domain/use_case/get_exam_history_use_case.dart';
import 'package:exam_mobile_app/presentation/exam/answers/cubit/exam_answers_event.dart';
import 'package:exam_mobile_app/presentation/exam/answers/cubit/exam_answers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExamAnswersCubit extends Cubit<ExamAnswersState> {
  final ExamQuestionUseCase _examQuestionUseCase;
  final GetExamHistoryUseCase _getExamHistoryUseCase;

  ExamAnswersCubit(
    this._examQuestionUseCase,
    this._getExamHistoryUseCase,
  ) : super(ExamAnswersState.initial());

  Future<void> doIntent(ExamAnswersEvent event) async {
    switch (event) {
      case LoadExamAnswers(:final examId):
        await _loadExamAnswers(examId);
    }
  }

  Future<void> _loadExamAnswers(String examId) async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
      ),
    );

    try {
      final questionsResult =
          await _examQuestionUseCase.call(examId);

      final histories =
          await _getExamHistoryUseCase.call();

      final history = histories.firstWhere(
        (history) => history.examId == examId,
      );

      emit(
        state.copyWith(
          isLoading: false,
          questions: questionsResult.data ?? [],
          history: history,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}