import 'package:hive/hive.dart';

import 'exam_history.dart';

class AttemptedQuestionAdapter extends TypeAdapter<AttemptedQuestion> {
  @override
  final int typeId = 1;

  @override
  AttemptedQuestion read(BinaryReader reader) {
    final fields = reader.readMap();

    return AttemptedQuestion(
      questionId: fields[0] as String,
      question: fields[1] as String,
      userAnswer: fields[2] as String,
      isCorrect: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AttemptedQuestion obj) {
    writer.writeMap({
      0: obj.questionId,
      1: obj.question,
      2: obj.userAnswer,
      3: obj.isCorrect,
    });
  }
}