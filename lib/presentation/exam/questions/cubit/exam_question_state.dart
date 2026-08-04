import 'package:exam_mobile_app/data/models/exam_question_response.dart';

class ExamQuestionState {
  final int duration;
  final int currentQuestion;
  final List<QuestionResponse> questions;
  final bool isLoading;
  final Map<int, Set<String>> selectedAnswers;

  ExamQuestionState({
    required this.duration,
    required this.currentQuestion,
    required this.questions,
    required this.isLoading,
    required this.selectedAnswers,
  });

  ExamQuestionState.initial()
    : this(
        duration: 60 * 20,
        currentQuestion: 0,
        questions: [],
        isLoading: false,
        selectedAnswers: {},
      );

  ExamQuestionState copyWith({
    int? duration,
    int? currentQuestion,
    List<QuestionResponse>? questions,
    bool? isLoading,
    Map<int, Set<String>>? selectedAnswers,
  }) {
    return ExamQuestionState(
      duration: duration ?? this.duration,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      questions: questions ?? this.questions,
      isLoading: isLoading ?? this.isLoading,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
    );
  }
}
