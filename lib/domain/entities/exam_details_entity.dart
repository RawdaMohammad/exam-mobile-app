class ExamDetailsEntity {
  final String id;
  final String title;
  final int duration;
  final String subject;
  final int numberOfQuestions;

  const ExamDetailsEntity({
    required this.id,
    required this.title,
    required this.duration,
    required this.subject,
    required this.numberOfQuestions,
  });
}