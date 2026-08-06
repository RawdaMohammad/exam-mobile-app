import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/widgets/answer_item.dart';
import 'package:exam_mobile_app/presentation/exam/answers/cubit/exam_answers_cubit.dart';
import 'package:exam_mobile_app/presentation/exam/answers/cubit/exam_answers_event.dart';
import 'package:exam_mobile_app/presentation/exam/answers/cubit/exam_answers_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamAnswersView extends StatefulWidget {
  final String examId;
  const ExamAnswersView({super.key, required this.examId});

  @override
  State<ExamAnswersView> createState() => _ExamAnswersViewState();
}

class _ExamAnswersViewState extends State<ExamAnswersView> {
  @override
  void initState() {
    super.initState();
    context.read<ExamAnswersCubit>().doIntent(LoadExamAnswers(widget.examId));
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
        title: Text("answers".tr(), style: Theme.of(context).textTheme.titleLarge),
      ),
      body:BlocBuilder<ExamAnswersCubit, ExamAnswersState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.errorMessage != null) {
            return Center(
              child: Text(state.errorMessage!),
            );
          }

          if (state.history == null) {
            return Center(
              child: Text("no_exam_history_found".tr()),
            );
          }

          if (state.questions.isEmpty) {
            return Center(
              child: Text("no_questions_found".tr()),
            );
          }
return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(state.questions.length, (questionIndex) {
              final questionData = state.questions[questionIndex];

              final attemptedQuestion = state.history!.questions.firstWhere(
                (attempted) => attempted.questionId == questionData.id,
              );
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 36),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(121, 201, 201, 201),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(100, 152, 151, 151),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            questionData.question ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        SizedBox(height: 24),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: questionData.answers?.length ?? 0,
                          itemBuilder: (context, index) {
                            final answer = questionData.answers![index];
                            final hasUserAnswer =
                                attemptedQuestion.userAnswer.isNotEmpty;

                            final isSelected =
                                hasUserAnswer &&
                                answer.key == attemptedQuestion.userAnswer;

                            final isCorrect =
                                hasUserAnswer &&
                                answer.key == questionData.correct;

                            final isWrongSelected = isSelected && !isCorrect;
                            return AnswerItem(
                              answer: answer.answer ?? '',
                              isSelected: isSelected || isCorrect,
                              isSingleChoice:
                                  questionData.type == "single_choice",
                              selectedColor: isCorrect
                                  ? const Color.fromARGB(
                                      255,
                                      61,
                                      228,
                                      67,
                                    ).withValues(alpha: 0.2)
                                  : isWrongSelected
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.error.withValues(alpha: 0.2)
                                  : const Color(0xFFEDEFF3),
                              borderColor: isCorrect
                                  ? const Color.fromARGB(255, 61, 228, 67)
                                  : isWrongSelected
                                  ? Theme.of(context).colorScheme.error
                                  : Colors.transparent,

                              unselectedColor: const Color(0xFFEDEFF3),
                              iconColor: isCorrect
                                  ? const Color.fromARGB(255, 61, 228, 67)
                                  : isWrongSelected
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).primaryColor,

                              onTap: () {},
                            );
                          },
                        ),
                      ],
                    ),
                  ),
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