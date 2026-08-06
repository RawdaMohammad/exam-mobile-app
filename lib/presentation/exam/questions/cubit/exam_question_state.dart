import 'package:exam_mobile_app/data/models/exam_question_response.dart';

class ExamQuestionState {
  final int initialDuration;
  final int duration;
  final int currentQuestion;
  final List<QuestionResponse> questions;
  final bool isLoading;
  final Map<int, Set<String>> selectedAnswers;
  final String examId;
  final String subjectId;

  ExamQuestionState({
    required this.initialDuration,
    required this.duration,
    required this.currentQuestion,
    required this.questions,
    required this.isLoading,
    required this.selectedAnswers,
    required this.examId,
    required this.subjectId,
  });

  ExamQuestionState.initial()
    : this(
        initialDuration: 0,
        duration: 0,
        currentQuestion: 0,
        questions: [],
        isLoading: false,
        selectedAnswers: {},
        examId: '',
        subjectId: '',
      );

  ExamQuestionState copyWith({
    int? initialDuration,
    int? duration,
    int? currentQuestion,
    List<QuestionResponse>? questions,
    bool? isLoading,
    Map<int, Set<String>>? selectedAnswers,
    String? examId,
    String? subjectId,
  }) {
    return ExamQuestionState(
      initialDuration: initialDuration ?? this.initialDuration,
      duration: duration ?? this.duration,
      currentQuestion: currentQuestion ?? this.currentQuestion,
      questions: questions ?? this.questions,
      isLoading: isLoading ?? this.isLoading,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      examId: examId ?? this.examId,
      subjectId: subjectId ?? this.subjectId,
    );
  }
}
