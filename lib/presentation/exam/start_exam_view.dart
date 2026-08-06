import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/di/di.dart';
import 'package:exam_mobile_app/core/widgets/custom_button.dart';
import 'package:exam_mobile_app/domain/entities/exam_details_entity.dart';
import 'package:exam_mobile_app/domain/entities/subject_entity.dart';
import 'package:exam_mobile_app/presentation/exam/questions/cubit/exam_question_cubit.dart';
import 'package:exam_mobile_app/presentation/exam/questions/exam_questions_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartExamView extends StatefulWidget {
  final ExamDetailsEntity examDetails;
  final SubjectEntity subject;
  const StartExamView({
    super.key,
    required this.examDetails,
    required this.subject,
  });

  @override
  State<StartExamView> createState() => _StartExamViewState();
}

class _StartExamViewState extends State<StartExamView> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Image.network(widget.subject.icon, width: 48),
                    const SizedBox(width: 8),
                    Text(widget.subject.name, style: textTheme.titleLarge),
                    const Spacer(),
                    Text(
                      "${widget.examDetails.duration} Minutes",
                      style: textTheme.bodySmall?.copyWith(
                        color: color.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: widget.examDetails.title,
                        style: textTheme.titleMedium,
                      ),
                      TextSpan(
                        text:
                            "| ${widget.examDetails.numberOfQuestions} Questions",
                        style: textTheme.bodyLarge?.copyWith(
                          color: color.tertiary,
                        ), // Different style
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                CustomButton(
                  buttonLabel: tr("startExam.startButton"),
                  isNotDisabled: true,
                  onPressedAction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => getIt<ExamQuestionCubit>(),
                          child: ExamQuestionsView(
                            examId: widget.examDetails.id,
                          ),
                        ),
                      ),
                    );
                  },
                  isLoading: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
