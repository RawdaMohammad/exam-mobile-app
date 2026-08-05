import 'package:equatable/equatable.dart';
import '../../../../domain/entities/subject_entity.dart';

class ExploreState extends Equatable {
  final List<SubjectEntity> subjects;
  final List<SubjectEntity> filteredSubjects;
  final bool isLoading;
  final String searchQuery;

  const ExploreState({
    this.subjects = const [],
    this.filteredSubjects = const [],
    this.isLoading = false,
    this.searchQuery = ''
  });

  ExploreState copyWith({List<SubjectEntity>? subjects, List<SubjectEntity>? filteredSubjects, bool? isLoading, String? searchQuery}) {
    return ExploreState(
      subjects: subjects ?? this.subjects,
      filteredSubjects: filteredSubjects ?? this.filteredSubjects,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery
    );
  }

  @override
  List<Object?> get props => [subjects, filteredSubjects, isLoading, searchQuery];
}