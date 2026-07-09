import 'package:flutter/material.dart';

class PasswordRule extends StatelessWidget {
  const PasswordRule({
    super.key,
    required this.title,
    required this.valid,
  });

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
            color: valid ? Colors.green : Colors.red,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              color: valid ? Colors.green : Colors.red,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}