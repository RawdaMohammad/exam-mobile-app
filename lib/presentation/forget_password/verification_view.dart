import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/widgets/otp_input.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/forget_password_events.dart';
import 'package:exam_mobile_app/presentation/forget_password/cubit/forget_password_state.dart';
import 'package:exam_mobile_app/presentation/forget_password/reset_password_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  late ForgetPasswordCubit forgetPasswordCubit;
  late StreamSubscription<ForgetPasswordUIEvents> _subscription;

  @override
  void initState() {
    super.initState();
    forgetPasswordCubit = context.read<ForgetPasswordCubit>();
    _subscription = forgetPasswordCubit.uiStream.listen((event) {
      switch (event) {
        case NavigateToResetPassword():
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<ForgetPasswordCubit>(),
                child: const ResetPasswordView(),
              ),
            ),
          );
        case ShowSnackBar():
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(event.message)));
        default:
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
    var textTheme = Theme.of(context).textTheme;
    var color = Theme.of(context).colorScheme;
    return BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
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
              style: textTheme.titleLarge,
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
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tr("verification.description"),
                      style: textTheme.bodyMedium?.copyWith(
                        color: color.tertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    OtpInput(
                      key: ValueKey(state.resetCode),
                      onCompleted: (otp) {
                        context.read<ForgetPasswordCubit>().doIntent(VerifyResetCodeEvent(otp));
                      },
                    ),
                    if (state.isLoading!)
                      const CircularProgressIndicator(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tr("verification.didNotReceiveCode"),
                          style: textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: state.isLoading
                              ? null
                              : () {
                            context.read<ForgetPasswordCubit>().doIntent(
                                    ResendResetCodeEvent(),
                                  );
                                },
                          child: Text(
                            tr("verification.resend"),
                            style: textTheme.bodyLarge
                                ?.copyWith(
                              color: color.primary,
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
    );
  }
}