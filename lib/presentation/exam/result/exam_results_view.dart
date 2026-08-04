import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/di/di.dart';
import 'package:exam_mobile_app/core/widgets/subject_result_card.dart';
import 'package:exam_mobile_app/presentation/exam/answers/cubit/exam_answers_cubit.dart';
import 'package:exam_mobile_app/presentation/exam/result/cubit/exam_results_cubit.dart';
import 'package:exam_mobile_app/presentation/exam/result/cubit/exam_results_event.dart';
import 'package:exam_mobile_app/presentation/exam/result/cubit/exam_results_state.dart';
import 'package:exam_mobile_app/presentation/exam/answers/exam_answers_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamResultsView extends StatefulWidget {
  const ExamResultsView({super.key});

  @override
  State<ExamResultsView> createState() => _ExamResultsViewState();
}

class _ExamResultsViewState extends State<ExamResultsView> {
  late final StreamSubscription<ExamResultsUIEvent> _subscription;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<ExamResultsCubit>();
    cubit.doIntent(LoadExamResults());

    _subscription = cubit.uiStream.listen((event) {
      switch (event) {
        case NavigateToExamAnswers(:final examId):
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => getIt<ExamAnswersCubit>(),
                child: ExamAnswersView(examId: examId),
              ),
            ),
          );
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          "results".tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocBuilder<ExamResultsCubit, ExamResultsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          if (state.histories.isEmpty) {
            return Center(child: Text("no_exam_results".tr()));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(state.subjects.length, (subjectIndex) {
                  final subjectId = state.subjects.keys.elementAt(subjectIndex);
                  final subject = state.subjects[subjectId]!;

                  final subjectHistories = state.histories
                      .where((history) => history.subjectId == subjectId)
                      .toList();

                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          subject.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),

                      const SizedBox(height: 24),

                      ...List.generate(subjectHistories.length, (index) {
                        final history = subjectHistories[index];
                        final exam = state.exams[history.examId]!;

                        final numOfCorrectAnswers = history.questions
                            .where((question) => question.isCorrect)
                            .length;
                        final minutes = history.timeTaken ~/ 60;
                        final seconds = history.timeTaken % 60;

                        final formattedTakenTime =
                            "$minutes:${seconds.toString().padLeft(2, '0')}";

                        return SubjectResultCard(
                          duration: exam.duration,
                          numberOfQuestions: history.questionCount,
                          numOfCorrectAnswers: numOfCorrectAnswers,
                          takenTime: formattedTakenTime,
                          examTitle: exam.title,
                          image: subject.icon,
                          onTap: () {
                            context.read<ExamResultsCubit>().doIntent(
                              OpenExamAnswers(history.examId),
                            );
                          },
                        );
                      }),
                    ],
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
