import 'dart:async';

import 'package:exam_mobile_app/domain/entities/exam_details_entity.dart';
import 'package:exam_mobile_app/domain/entities/subject_details_entity.dart';
import 'package:exam_mobile_app/domain/use_case/get_exam_history_use_case.dart';
import 'package:exam_mobile_app/domain/use_case/get_exam_use_case.dart';
import 'package:exam_mobile_app/domain/use_case/get_subject_use_case.dart';
import 'package:exam_mobile_app/presentation/exam/result/cubit/exam_results_event.dart';
import 'package:exam_mobile_app/presentation/exam/result/cubit/exam_results_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExamResultsCubit extends Cubit<ExamResultsState> {
  final GetExamHistoryUseCase _getExamHistoryUseCase;
  final GetExamUseCase _getExamUseCase;
  final GetSubjectUseCase _getSubjectUseCase;

  ExamResultsCubit(
    this._getExamUseCase,
    this._getSubjectUseCase,
    this._getExamHistoryUseCase,
  ) : super(ExamResultsState.initial());

  final StreamController<ExamResultsUIEvent> _uiController =
      StreamController.broadcast();

  Stream<ExamResultsUIEvent> get uiStream => _uiController.stream;

  Future<void> doIntent(ExamResultsEvent event) async {
    switch (event) {
      case LoadExamResults():
        await _loadExamResults();
      case OpenExamAnswers(:final examId):
        await _openExamAnswers(examId);
    }
  }

  Future<void> _openExamAnswers(String examId) async {
    _uiController.add(NavigateToExamAnswers(examId));
  }

  Future<void> _loadExamResults() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final histories = await _getExamHistoryUseCase.call();

      final subjectIds = histories.map((history) => history.subjectId).toSet();

      final examIds = histories.map((history) => history.examId).toSet();

      final subjects = <String, SubjectDetailsEntity>{};
      final exams = <String, ExamDetailsEntity>{};

      for (final subjectId in subjectIds) {
        final response = await _getSubjectUseCase.call(subjectId);
        subjects[subjectId] = response;
      }

      for (final examId in examIds) {
        final response = await _getExamUseCase.call(examId);
        exams[examId] = response;
      }

      emit(
        state.copyWith(
          isLoading: false,
          histories: histories,
          subjects: subjects,
          exams: exams,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _uiController.close();
    return super.close();
  }
}
