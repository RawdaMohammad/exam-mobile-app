import 'package:flutter/material.dart';

class  PasswordValidationSupportText extends StatelessWidget {
  const PasswordValidationSupportText({super.key, required this.title, required this.valid});


  final String title;
  final bool valid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Icon(
            valid ? Icons.check_circle : Icons.cancel,
            color: valid
                ? Colors.green
                : Theme.of(context).colorScheme.error,
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: valid
                  ? Colors.green
                  : Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
