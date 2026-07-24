import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/widgets/custom_button.dart';
import 'package:exam_mobile_app/core/widgets/otp_input.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/verification_cubit.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/verification_events.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/verification_state.dart';
import 'package:exam_mobile_app/presentation/forget_password/reset_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/di.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final VerificationCubit verificationCubit = getIt();
  late final StreamSubscription<VerificationUIEvents> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = verificationCubit.uiStream.listen((event) {
      switch (event) {
        case NavigateToResetPassword():
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ResetPasswordView()),
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: verificationCubit,
      child: BlocBuilder<VerificationCubit, VerificationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 25,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {},
              ),
              title: Text(
                tr("passwordAppBar"),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        tr("verification.title"),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        tr("verification.description"),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      OtpInput(
                        key: ValueKey(state.resetCode),
                        onCompleted: (otp) {
                          verificationCubit.doIntent(CheckResetCodeEvent(otp));
                        },
                      ),
                      if (state.isLoading)
                        const CircularProgressIndicator(),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr("verification.didNotReceiveCode"),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: state.isLoading
                                ? null
                                : () {
                                    verificationCubit.doIntent(
                                      ResendResetCodeEvent(),
                                    );
                                  },
                            child: Text(
                              tr("verification.resend"),
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}