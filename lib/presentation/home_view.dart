import 'package:exam_mobile_app/core/widgets/custom_navigation_bar.dart';
import 'package:exam_mobile_app/presentation/exam/result/cubit/exam_results_cubit.dart';
import 'package:exam_mobile_app/presentation/exam/result/exam_results_view.dart';
import 'package:exam_mobile_app/presentation/forget_password/reset_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/di/di.dart';
import 'exam/explorer/cubit/explore_cubit.dart';
import 'exam/explorer/cubit/explore_events.dart';
import 'exam/explorer/explore_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          BlocProvider(
            create: (_) => getIt<ExploreCubit>()
              ..doIntent(LoadSubjects()),
            child: const ExploreView(),
          ),
          BlocProvider(
            create: (_) => getIt<ExamResultsCubit>(),
            child: const ExamResultsView(),
          ),
          BlocProvider(
            create: (_) => getIt<ExploreCubit>(),
            child: const ResetPasswordView(),
          ),
        ],
      ),
    );
  }
}