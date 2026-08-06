import 'package:equatable/equatable.dart';
import 'package:exam_mobile_app/domain/entities/exam_details_entity.dart';

class SubjectState extends Equatable {
  final bool isLoading;
  final List<ExamDetailsEntity> exams;

  const SubjectState({this.isLoading = false, this.exams = const []});

  SubjectState copyWith({bool? isLoading, List<ExamDetailsEntity>? exams}) {
    return SubjectState(
      isLoading: isLoading ?? this.isLoading,
      exams: exams ?? this.exams,
    );
  }

  @override
  List<Object?> get props => [isLoading, exams];
}
