sealed class ExploreEvents {}

class LoadSubjects extends ExploreEvents {}

class SearchSubjects extends ExploreEvents {
  final String searchQuery;
  SearchSubjects(this.searchQuery);
}

class SubjectClicked extends ExploreEvents {
  final String subjectID;
  SubjectClicked(this.subjectID);
}

sealed class ExploreUIEvents {}

class NavigateToSubjectExams extends ExploreUIEvents {
  final String subjectID;
  NavigateToSubjectExams(this.subjectID);
}

class ShowSnackBar extends ExploreUIEvents {
  final String message;
  ShowSnackBar (this.message);
}
