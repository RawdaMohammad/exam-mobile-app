import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.isLoading,
    required this.isNotDisabled,
    required this.buttonLabel,
    required this.onPressedAction,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.textColor,
    this.borderColor,
  });

  final bool isLoading;
  final bool isNotDisabled;
  final String buttonLabel;
  final VoidCallback onPressedAction;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: isLoading || !isNotDisabled
        ? null
        : onPressedAction,
        style: FilledButton.styleFrom(
          backgroundColor: isNotDisabled
              ? (backgroundColor ?? Theme.of(context).colorScheme.primary)
              : (disabledBackgroundColor ??
                    Theme.of(context).colorScheme.secondary),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: 1.5,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                buttonLabel,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
      ),
    );
  }
}