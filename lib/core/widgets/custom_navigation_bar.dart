import 'package:flutter/material.dart';

import 'nav_item.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFFEDEFF3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavItem(
            icon: Icons.home_outlined,
            label: "Explore",
            selected: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          NavItem(
            icon: Icons.assignment_outlined,
            label: "Result",
            selected: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          NavItem(
            icon: Icons.person_outline,
            label: "Profile",
            selected: currentIndex == 2,
            onTap: () => onTap(2),
          ),
        ],
      ),
    );
  }
}
