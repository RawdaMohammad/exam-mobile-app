import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/presentation/exam/explorer/cubit/explore_cubit.dart';
import 'package:exam_mobile_app/presentation/exam/explorer/cubit/explore_events.dart';
import 'package:exam_mobile_app/presentation/forget_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/subject_card.dart';
import 'cubit/explore_state.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  late ExploreCubit exploreCubit;
  late StreamSubscription<ExploreUIEvents> _subscription;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    exploreCubit = context.read<ExploreCubit>();
    _subscription = exploreCubit.uiStream.listen((event) {
      switch (event) {
        case NavigateToSubjectExams():
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ForgetPasswordView()),
          );
        case ShowSnackBar():
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(event.message)));
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var color = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr("appBar.explore"),
              style: textTheme.titleLarge!.copyWith(color: color.primary),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: textTheme.bodyMedium,
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFFA6A6A6),
                  size: 25,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF535353)),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color.primary),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {
                context.read<ExploreCubit>().doIntent(SearchSubjects(value));
              },
            ),
            const SizedBox(height: 40),
            Text(tr("explore.title"), style: textTheme.titleLarge),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<ExploreCubit, ExploreState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemCount: state.filteredSubjects.length,
                    itemBuilder: (context, index) {
                      final subject = state.filteredSubjects[index];
                      return SubjectCard(
                        subject: subject,
                        onTap: () {
                          debugPrint("Clicked: ${subject.id}");
                          context.read<ExploreCubit>().doIntent(
                            SubjectClicked(subject.id),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}