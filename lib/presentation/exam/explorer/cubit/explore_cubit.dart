import 'dart:async';
import 'package:exam_mobile_app/core/network/api_results.dart';
import 'package:exam_mobile_app/domain/entities/subject_entity.dart';
import 'package:exam_mobile_app/domain/use_case/get_subjects_use_case.dart';
import 'package:exam_mobile_app/presentation/exam/explorer/cubit/explore_events.dart';
import 'package:exam_mobile_app/presentation/exam/explorer/cubit/explore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  final GetSubjectsUseCase _getSubjectsUseCase;
  ExploreCubit(this._getSubjectsUseCase): super(ExploreState());

  final StreamController<ExploreUIEvents> _uiController = StreamController.broadcast();
  Stream<ExploreUIEvents> get uiStream => _uiController.stream;

  Future<void> doIntent(ExploreEvents event) async{
    switch(event){
      case LoadSubjects():
        await _loadSubjects();
      case SearchSubjects():
        _searchSubjects(event.searchQuery);
      case SubjectClicked():
        _navigateToSubjectExams(event.subject);
    }
  }

  Future<void> _loadSubjects() async{
    emit(state.copyWith(isLoading: true));
    var subjects = await _getSubjectsUseCase.call();
    switch(subjects){
      case Success<List<SubjectEntity>>():
        emit(state.copyWith(subjects: subjects.data, isLoading: false, filteredSubjects: subjects.data));
      case Failure<List<SubjectEntity>>():
        emit(state.copyWith(isLoading: false));
        _uiController.add(ShowSnackBar(subjects.message!));
    }
  }

  void _searchSubjects(String searchQuery) {
    var filteredSubjects = state.subjects.where(
          (subject) => subject.name.toLowerCase().contains(searchQuery.toLowerCase().trim()),).toList();
    emit(state.copyWith(filteredSubjects: filteredSubjects));
  }

  void _navigateToSubjectExams(SubjectEntity subject){
    _uiController.add(NavigateToSubjectExams(subject));
  }
}