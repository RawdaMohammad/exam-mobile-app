import 'package:flutter/material.dart';

class AnswerItem extends StatelessWidget {
  const AnswerItem({
    super.key,
    required this.answer,
    required this.isSelected,
    required this.isSingleChoice,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
    required this.iconColor,
  });

  final String answer;
  final bool isSelected;
  final bool isSingleChoice;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? selectedColor : unselectedColor,
        ),
        child: Row(
          children: [
            if (isSingleChoice)
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                size: 24,
                color: iconColor,
              )
            else
              Icon(
                isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                size: 24,
                color: iconColor,
              ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                answer,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
