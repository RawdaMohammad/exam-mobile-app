import 'package:easy_localization/easy_localization.dart';
import 'package:exam_mobile_app/core/widgets/custom_button.dart';
import 'package:exam_mobile_app/presentation/verification_view.dart';
import 'package:flutter/material.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  bool _isEmailValid = false;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: Text(tr("passwordAppBar"), style: Theme.of(context).textTheme.titleMedium,),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(tr("forgetPassword.title"), style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 16,),
              Text(tr("forgetPassword.description"), style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,),
              const SizedBox(height: 32,),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "forgetPassword.emailLabel".tr(),
                  hintText: "forgetPassword.emailHint".tr(),
                  errorText: _errorText,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                ),
                onChanged: (value){
                  setState(() {
                    if (value.isEmpty) {
                      _errorText = tr("forgetPassword.emailRequired");
                      _isEmailValid = false;
                    }

                    else if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {

                      _errorText = tr("forgetPassword.invalidEmail");
                      _isEmailValid = false;
                    }

                    else {
                      _errorText = null;
                      _isEmailValid = true;
                    }

                  });
                },
              ),
              const SizedBox(height: 48,),
              CustomButton(
                isNotDisabled: _isEmailValid,
                buttonLabel: tr("forgetPassword.continueButton"),
                onPressedAction:  () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VerificationView(),
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