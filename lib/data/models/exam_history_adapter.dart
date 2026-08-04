import 'package:hive/hive.dart';

import 'exam_history.dart';

class ExamHistoryAdapter extends TypeAdapter<ExamHistory> {
  @override
  final int typeId = 0;

  @override
  ExamHistory read(BinaryReader reader) {
    final fields = reader.readMap();

    return ExamHistory(
      examId: fields[0] as String,
      subjectId: fields[1] as String,
      questionCount: fields[2] as int,
      timeTaken: fields[3] as int,
      attemptedAt: DateTime.parse(fields[4] as String),
      questions: (fields[5] as List).cast<AttemptedQuestion>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExamHistory obj) {
    writer.writeMap({
      0: obj.examId,
      1: obj.subjectId,
      2: obj.questionCount,
      3: obj.timeTaken,
      4: obj.attemptedAt.toIso8601String(),
      5: obj.questions,
    });
  }
}