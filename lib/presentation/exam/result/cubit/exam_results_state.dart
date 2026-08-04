import 'package:exam_mobile_app/domain/entities/exam_details_entity.dart';
import 'package:exam_mobile_app/domain/entities/exam_history_entity.dart';
import 'package:exam_mobile_app/domain/entities/subject_details_entity.dart';

class ExamResultsState {
  final bool isLoading;
  final List<ExamHistoryEntity> histories;
  final Map<String, SubjectDetailsEntity> subjects;
  final Map<String, ExamDetailsEntity> exams;
  final String? errorMessage;

  const ExamResultsState({
    required this.isLoading,
    required this.histories,
    required this.subjects,
    required this.exams,
    this.errorMessage,
  });

  ExamResultsState.initial()
    : this(isLoading: false, histories: [], subjects: {}, exams: {});

  ExamResultsState copyWith({
    bool? isLoading,
    List<ExamHistoryEntity>? histories,
    Map<String, SubjectDetailsEntity>? subjects,
    Map<String, ExamDetailsEntity>? exams,
    String? errorMessage,
  }) {
    return ExamResultsState(
      isLoading: isLoading ?? this.isLoading,
      histories: histories ?? this.histories,
      subjects: subjects ?? this.subjects,
      exams: exams ?? this.exams,
      errorMessage: errorMessage,
    );
  }
}
