import 'package:exam_mobile_app/domain/entities/subject_entity.dart';

sealed class ExploreEvents {}

class LoadSubjects extends ExploreEvents {}

class SearchSubjects extends ExploreEvents {
  final String searchQuery;
  SearchSubjects(this.searchQuery);
}

class SubjectClicked extends ExploreEvents {
  final SubjectEntity subject;
  SubjectClicked(this.subject);
}

sealed class ExploreUIEvents {}

class NavigateToSubjectExams extends ExploreUIEvents {
  final SubjectEntity subject;
  NavigateToSubjectExams(this.subject);
}

class ShowSnackBar extends ExploreUIEvents {
  final String message;
  ShowSnackBar(this.message);
}
