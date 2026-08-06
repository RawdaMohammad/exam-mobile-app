import 'dart:async';
import 'package:exam_mobile_app/presentation/exam/subject/cubit/subject_event.dart';
import 'package:exam_mobile_app/presentation/exam/subject/cubit/subject_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/domain/entities/exam_details_entity.dart';
import 'package:exam_mobile_app/domain/entities/subject_entity.dart';
import 'package:exam_mobile_app/domain/use_case/get_exam_by_subject_use_case.dart';

@injectable
class SubjectCubit extends Cubit<SubjectState> {
  final GetExamsBySubjectUseCase _getExamsBySubjectUseCase;

  SubjectCubit(this._getExamsBySubjectUseCase) : super(const SubjectState());

  final StreamController<SubjectUIEvents> _uiController =
      StreamController.broadcast();

  Stream<SubjectUIEvents> get uiStream => _uiController.stream;

  Future<void> doIntent(SubjectEvents event) async {
    switch (event) {
      case LoadExams():
        await _loadExams(event.subject);

      case ExamClicked():
        _navigateToExamRestrictions(event.subject, event.exam);
    }
  }

  Future<void> _loadExams(SubjectEntity subject) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getExamsBySubjectUseCase(subject.id);

    switch (result) {
      case Success<List<ExamDetailsEntity>>():
        emit(state.copyWith(isLoading: false, exams: result.data ?? []));

      case Failure<List<ExamDetailsEntity>>():
        emit(state.copyWith(isLoading: false));

        _uiController.add(
          ShowSnackBar(result.message ?? "Something went wrong"),
        );
    }
  }

  void _navigateToExamRestrictions(
    SubjectEntity subject,
    ExamDetailsEntity exam,
  ) {
    _uiController.add(NavigateToExamRestrictions(subject: subject, exam: exam));
  }

  @override
  Future<void> close() {
    _uiController.close();
    return super.close();
  }
}
