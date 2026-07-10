import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInput extends StatefulWidget {
  final int otpNum;
  final ValueChanged<String> onCompleted;
  final bool hasError;

  const OtpInput({
    super.key,
    this.otpNum = 4,
    required this.onCompleted,
    this.hasError = false,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      widget.otpNum,
          (_) => TextEditingController(),
    );

    _focusNodes = List.generate(
      widget.otpNum,
          (_) => FocusNode(),
    );
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < widget.otpNum - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    }

    final otp = _controllers.map((e) => e.text).join();

    if (otp.length == widget.otpNum) {
      widget.onCompleted(otp);
    }

    setState(() {});
  }

  void _onBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.otpNum,
            (index) => SizedBox(
          width: 74,
          height: 68,
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              if (event.logicalKey == LogicalKeyboardKey.backspace) {
                _onBackspace(index);
              }
            },
            child: TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                counterText: "",
                filled: true,
                fillColor: widget.hasError ? Colors.transparent: Color(0xffDFE7F7),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color:
                    widget.hasError ? Colors.red : Colors.transparent,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color:
                    widget.hasError ? Colors.red : Colors.blue,
                    width: 2,
                  ),
                ),

                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),

              onChanged: (value) => _onChanged(value, index),
            ),
          ),
        ),
      ),
    );
  }
}