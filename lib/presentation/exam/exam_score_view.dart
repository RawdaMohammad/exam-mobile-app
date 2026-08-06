import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/di/di.dart';
import 'package:exam_mobile_app/core/widgets/custom_button.dart';
import 'package:exam_mobile_app/domain/entities/exam_resulr_entity.dart';
import 'package:exam_mobile_app/presentation/exam/questions/cubit/exam_question_cubit.dart';
import 'package:exam_mobile_app/presentation/exam/questions/exam_questions_view.dart';
import 'package:exam_mobile_app/presentation/exam/result/cubit/exam_results_cubit.dart';
import 'package:exam_mobile_app/presentation/exam/result/exam_results_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExamScoreView extends StatefulWidget {
  final ExamResultEntity result;

  const ExamScoreView({super.key, required this.result});

  @override
  State<ExamScoreView> createState() => _ExamScoreView();
}

class _ExamScoreView extends State<ExamScoreView> {
  @override
  Widget build(BuildContext context) {
    final correctAnswers = widget.result.correct;
    final wrongAnswers = widget.result.wrong;

    final total = correctAnswers + wrongAnswers;

    final percent = total == 0 ? 0.0 : correctAnswers / total;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 25,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          tr("exam_score"),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  tr("your_score"),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  CircularPercentIndicator(
                    radius: 75,
                    percent: percent,
                    lineWidth: 6,
                    animation: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: Theme.of(context).colorScheme.error,
                    progressColor: Theme.of(context).colorScheme.primary,
                    center: Text(
                      "${(percent * 100).toInt()}%",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              tr("correct"),
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                            Spacer(),
                            Container(
                              width: 29,
                              height: 29,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                correctAnswers.toString(),
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              tr("incorrect"),
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                            ),
                            Spacer(),
                            Container(
                              width: 29,
                              height: 29,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.error,
                                  width: 2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                wrongAnswers.toString(),
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.error,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),
              CustomButton(
                isLoading: false,
                isNotDisabled: true,
                buttonLabel: tr("show_results"),
                onPressedAction: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => getIt<ExamResultsCubit>(),
                        child: const ExamResultsView(),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 30),
              CustomButton(
                isLoading: false,
                isNotDisabled: true,
                backgroundColor: Colors.white,
                textColor: Theme.of(context).colorScheme.primary,
                borderColor: Theme.of(context).colorScheme.primary,
                buttonLabel: tr("start_again"),
                onPressedAction: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => getIt<ExamQuestionCubit>(),
                        child: const ExamQuestionsView(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
