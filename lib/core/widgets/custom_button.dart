import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.isNotDisabled,
    required this.buttonLabel,
    required this.onPressedAction,
  });

  final bool isNotDisabled;
  final String buttonLabel;
  final VoidCallback onPressedAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: isNotDisabled
            ? onPressedAction
            : null,
        style: FilledButton.styleFrom(
          backgroundColor: isNotDisabled? Theme.of(context).colorScheme.primary: Theme.of(context).colorScheme.secondary,
        ),
        child: Text(
         buttonLabel,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),

      ),
    );
  }
}