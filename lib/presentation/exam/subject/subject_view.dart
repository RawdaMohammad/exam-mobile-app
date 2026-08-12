import 'dart:async';
import 'package:exam_mobile_app/core/di/di.dart';
import 'package:exam_mobile_app/core/widgets/subject_result_card.dart';
import 'package:exam_mobile_app/domain/entities/subject_entity.dart';
import 'package:exam_mobile_app/presentation/exam/questions/cubit/exam_question_cubit.dart';
import 'package:exam_mobile_app/presentation/exam/subject/cubit/subject_event.dart';
import 'package:exam_mobile_app/presentation/exam/subject/cubit/subject_cubit.dart';
import 'package:exam_mobile_app/presentation/exam/subject/cubit/subject_state.dart';
import 'package:exam_mobile_app/presentation/exam/start_exam_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectView extends StatefulWidget {
  final SubjectEntity subject;

  const SubjectView({super.key, required this.subject});

  @override
  State<SubjectView> createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  late final SubjectCubit cubit;
  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

    cubit = context.read<SubjectCubit>();

    cubit.doIntent(LoadExams(widget.subject));

    _subscription = cubit.uiStream.listen((event) {
      if (!mounted) return;

      switch (event) {
        case NavigateToExamRestrictions():
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                  create: (_) => getIt<ExamQuestionCubit>(),
                  child: StartExamView(examDetails: event.exam, subject: event.subject,),
                ),
            ),
          );
          break;

        case ShowSnackBar(message: final message):
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
          break;
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
          widget.subject.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SubjectCubit, SubjectState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.exams.isEmpty) {
              return const Center(child: Text('No exams found'));
            }

            return ListView.builder(
              itemCount: state.exams.length,
              itemBuilder: (context, index) {
                final exam = state.exams[index];

                return SubjectResultCard(
                  duration: exam.duration,
                  numberOfQuestions: exam.numberOfQuestions,
                  examTitle: exam.title,
                  image: widget.subject.icon,
                  onTap: () {
                    cubit.doIntent(
                      ExamClicked(subject: widget.subject, exam: exam),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
