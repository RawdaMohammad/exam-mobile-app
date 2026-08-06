import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/utils/time_formatter.dart';
import 'package:exam_mobile_app/core/widgets/answer_item.dart';
import 'package:exam_mobile_app/core/widgets/time_out_dialog.dart';
import 'package:exam_mobile_app/presentation/exam/questions/cubit/exam_question_cubit.dart';
import 'package:exam_mobile_app/presentation/exam/questions/cubit/exam_question_event.dart';
import 'package:exam_mobile_app/presentation/exam/questions/cubit/exam_question_state.dart';
import 'package:exam_mobile_app/presentation/exam/exam_score_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamQuestionsView extends StatefulWidget {
  const ExamQuestionsView({super.key});

  @override
  State<ExamQuestionsView> createState() => _ExamQuestionsViewState();
}

class _ExamQuestionsViewState extends State<ExamQuestionsView> {
  late final StreamSubscription<ExamQuestionUIEvent> _subscription;

  @override
  void initState() {
    super.initState();
    context.read<ExamQuestionCubit>().doIntent(LoadExam());
    _subscription = context.read<ExamQuestionCubit>().uiStream.listen((event) {
      switch (event) {
        case ShowTimeOutDialog():
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => TimeOutDialog(
              onViewScore: () {
                Navigator.pop(context);
                context.read<ExamQuestionCubit>().doIntent(FinishExam());
              },
            ),
          );
        case NavigateToExamResult():
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ExamScoreView(result: event.result),
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
    return BlocBuilder<ExamQuestionCubit, ExamQuestionState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final question = state.questions[state.currentQuestion];
        final currentSelections =
            state.selectedAnswers[state.currentQuestion] ?? <String>{};

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
              "exam".tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            actions: [
              const Icon(Icons.alarm_sharp),
              const SizedBox(width: 5),
              Center(
                child: Text(
                  TimeFormatter.format(state.duration),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: state.duration > state.initialDuration / 2
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "question_progress".tr(
                    namedArgs: {
                      "current": "${state.currentQuestion + 1}",
                      "total": "${state.questions.length}",
                    },
                  ),
                ),
                LinearProgressIndicator(
                  value: (state.currentQuestion + 1) / state.questions.length,
                  minHeight: 4,
                  backgroundColor: Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    question.question,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: 24),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: question.answers.length,
                  itemBuilder: (context, index) {
                    final answer = question.answers[index];
                    final isSelected = currentSelections.contains(answer.key);

                    return AnswerItem(
                      answer: answer.answer,
                      isSelected: isSelected,
                      isSingleChoice: question.type == "single_choice",
                      selectedColor: const Color(0xFFCCD7EB),
                      unselectedColor: const Color(0xFFEDEFF3),
                      iconColor: Theme.of(context).primaryColor,
                      onTap: () {
                        context.read<ExamQuestionCubit>().doIntent(
                          SelectAnswer(
                            questionIndex: state.currentQuestion,
                            answerKey: answer.key,
                            isSingleChoice: question.type == "single_choice",
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: state.currentQuestion > 0
                            ? () {
                                context.read<ExamQuestionCubit>().doIntent(
                                  PreviousQuestion(),
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(150, 48),
                        ),
                        child: Text(
                          "back".tr(),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight(500),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (state.currentQuestion <
                              state.questions.length - 1) {
                            context.read<ExamQuestionCubit>().doIntent(
                              NextQuestion(),
                            );
                          } else {
                            context.read<ExamQuestionCubit>().doIntent(
                              FinishExam(),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          disabledBackgroundColor: Theme.of(
                            context,
                          ).primaryColor,
                          side: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(150, 48),
                        ),
                        child: Text(
                          state.currentQuestion == state.questions.length - 1
                              ? "finish".tr()
                              : "next".tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight(500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
