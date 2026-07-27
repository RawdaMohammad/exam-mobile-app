sealed class ExamQuestionEvent {}

class LoadExam extends ExamQuestionEvent {}

class StartTimer extends ExamQuestionEvent {}

class StopTimer extends ExamQuestionEvent {}

class NextQuestion extends ExamQuestionEvent {}

class PreviousQuestion extends ExamQuestionEvent {}

class SelectAnswer extends ExamQuestionEvent {
  final int questionIndex;
  final String answerKey;
  final bool isSingleChoice;

  SelectAnswer({
    required this.questionIndex,
    required this.answerKey,
    required this.isSingleChoice,
  });
}

sealed class ExamQuestionUIEvent {}

class ShowTimeOutDialog extends ExamQuestionUIEvent {}
