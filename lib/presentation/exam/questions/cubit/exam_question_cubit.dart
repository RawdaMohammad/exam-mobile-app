import 'dart:async';
import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/data/api/exam_api_client.dart';
import 'package:exam_mobile_app/data/request/submit_exam_request.dart';
import 'package:exam_mobile_app/domain/entities/exam_history_entity.dart';
import 'package:exam_mobile_app/domain/use_case/save_exam_history_use_case.dart';
import 'package:exam_mobile_app/domain/use_case/submit_exam_use_case.dart';
import 'package:exam_mobile_app/presentation/exam/questions/cubit/exam_question_event.dart';
import 'package:exam_mobile_app/presentation/exam/questions/cubit/exam_question_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExamQuestionCubit extends Cubit<ExamQuestionState> {
  final ExamApiClient _apiClient;
  final SaveExamHistoryUseCase _saveExamHistoryUseCase;
  final SubmitExamUseCase _submitExamUseCase;

  ExamQuestionCubit(
    this._submitExamUseCase,
    this._apiClient,
    this._saveExamHistoryUseCase,
  ) : super(ExamQuestionState.initial());

  Timer? _timer;
  final StreamController<ExamQuestionUIEvent> _uiController =
      StreamController.broadcast();

  Stream<ExamQuestionUIEvent> get uiStream => _uiController.stream;

  Future<void> doIntent(ExamQuestionEvent event) async {
    switch (event) {
      case StartTimer():
        await _startTimer();
      case StopTimer():
        await _stopTimer();
      case LoadExam():
        await _loadExam();
      case NextQuestion():
        emit(state.copyWith(currentQuestion: state.currentQuestion + 1));
      case PreviousQuestion():
        emit(state.copyWith(currentQuestion: state.currentQuestion - 1));
      case SelectAnswer():
        await _selectAnswer(event);
      case FinishExam():
        await _finishExam();
    }
  }

  Future<void> _startTimer() async {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.duration <= 1) {
        timer.cancel();
        emit(state.copyWith(duration: 0));
        _uiController.add(ShowTimeOutDialog());

        return;
      }

      emit(state.copyWith(duration: state.duration - 1));
    });
  }

  Future<void> _loadExam() async {
    emit(state.copyWith(isLoading: true));

    final response = await _apiClient.getExamQuestions(
      "69d9801a7c82914570305e5d",
    );
    final initialDuration = response.questions.first.exam.duration * 60;
    final subject = response.questions.first.subject;
    final exam = response.questions.first.exam;

    emit(
      state.copyWith(
        isLoading: false,
        questions: response.questions,
        examId: exam.id,
        subjectId: subject.id,
        initialDuration: initialDuration,
        duration: initialDuration,
      ),
    );
    await _startTimer();
  }

  Future<void> _selectAnswer(SelectAnswer event) async {
    final answers = <int, Set<String>>{};

    state.selectedAnswers.forEach((key, value) {
      answers[key] = Set<String>.from(value);
    });

    answers.putIfAbsent(event.questionIndex, () => <String>{});

    final selections = answers[event.questionIndex]!;

    if (event.isSingleChoice) {
      selections.clear();
      selections.add(event.answerKey);
    } else {
      if (selections.contains(event.answerKey)) {
        selections.remove(event.answerKey);
      } else {
        selections.add(event.answerKey);
      }
    }

    emit(state.copyWith(selectedAnswers: answers));
  }

  List<ExamAnswerRequest> _buildSubmitAnswers() {
    final answers = <ExamAnswerRequest>[];

    for (int i = 0; i < state.questions.length; i++) {
      final question = state.questions[i];

      final selectedAnswers = state.selectedAnswers[i] ?? <String>{};

      if (selectedAnswers.isEmpty) {
        answers.add(ExamAnswerRequest(questionId: question.id, correct: " "));
      } else {
        for (final answer in selectedAnswers) {
          answers.add(
            ExamAnswerRequest(questionId: question.id, correct: answer),
          );
        }
      }
    }

    return answers;
  }

  Future<void> _finishExam() async {
    await _stopTimer();

    final answers = _buildSubmitAnswers();
    final timeTaken = _calculateTimeTaken();

    final request = SubmitExamRequest(answers: answers, time: timeTaken);

    final result = await _submitExamUseCase.call(request);

    switch (result) {
      case Success(data: final data):
        if (data != null) {
          final history = _buildExamHistory();

          await _saveExamHistoryUseCase(history);

          _uiController.add(NavigateToExamResult(data));
        }

      case Failure():
        break;
    }
  }

  int _calculateTimeTaken() {
    return state.initialDuration - state.duration;
  }

  ExamHistoryEntity _buildExamHistory() {
    final attemptedQuestions = <AttemptedQuestionEntity>[];

    for (int i = 0; i < state.questions.length; i++) {
      final question = state.questions[i];

      final selectedAnswers = state.selectedAnswers[i] ?? <String>{};

      final userAnswer = selectedAnswers.join(', ');

      final isCorrect =
          selectedAnswers.length == 1 &&
          selectedAnswers.first == question.correct;

      attemptedQuestions.add(
        AttemptedQuestionEntity(
          questionId: question.id,
          question: question.question,
          userAnswer: userAnswer,
          isCorrect: isCorrect,
        ),
      );
    }

    return ExamHistoryEntity(
      examId: state.examId,
      subjectId: state.subjectId,
      questionCount: state.questions.length,
      timeTaken: _calculateTimeTaken(),
      attemptedAt: DateTime.now(),
      questions: attemptedQuestions,
    );
  }

  Future<void> _stopTimer() async {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    await _uiController.close();
    return super.close();
  }
}
