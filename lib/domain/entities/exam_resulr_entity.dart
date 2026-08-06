class ExamResultEntity {
  final int correct;
  final int wrong;
  final String total;

  const ExamResultEntity({
    required this.correct,
    required this.wrong,
    required this.total,
  });
}
