import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/widgets/custom_button.dart';
import 'package:exam_mobile_app/core/widgets/otp_input.dart';
import 'package:exam_mobile_app/presentation/reset_password_view.dart';
import 'package:flutter/material.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 25,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: Text(tr("passwordAppBar"), style: Theme.of(context).textTheme.titleLarge,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(tr("verification.title"), style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16,),
            Text(tr("verification.description"),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              textAlign: TextAlign.center,),
            const SizedBox(height: 32,),
            OtpInput(onCompleted: (otp){
              debugPrint(otp);
            }),
            const SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(tr("verification.didNotReceiveCode"), style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(width: 8,),
                GestureDetector(
                  child: Text(tr("verification.resend"),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                      ),
                  ),
                  onTap: (){
                    // ToDo <<==
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ResetPasswordView()
                        )
                    );
                  },
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}