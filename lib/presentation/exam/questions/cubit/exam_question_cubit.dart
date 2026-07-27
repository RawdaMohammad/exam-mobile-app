import 'dart:async';
import 'package:exam_mobile_app/data/api/exam_api_client.dart';
import 'package:exam_mobile_app/presentation/exam/questions/cubit/exam_question_event.dart';
import 'package:exam_mobile_app/presentation/exam/questions/cubit/exam_question_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExamQuestionCubit extends Cubit<ExamQuestionState> {
  final ExamApiClient _api;
  ExamQuestionCubit(this._api) : super(ExamQuestionState.initial());
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
    }
  }

  Future<void> _startTimer() async {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.duration == 0) {
        _uiController.add(ShowTimeOutDialog());
        timer.cancel();
        return;
      }
      emit(state.copyWith(duration: state.duration - 1));
    });
  }

  Future<void> _loadExam() async {
    emit(state.copyWith(isLoading: true));

    final response = await _api.getExamQuestions("69d980117c82914570305dd5");

    emit(state.copyWith(isLoading: false, questions: response.questions));
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

  Future<void> _stopTimer() async {
    _timer?.cancel();
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    await _uiController.close();
    return super.close();
  }
}
