import 'package:flutter/material.dart';
import 'package:easymeasure/theme/theme.dart';

class NamePlate extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final IconData? icon;

  const NamePlate({
    super.key,
    required this.name,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: appBarColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: icon != null
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          spacing: 8,
          children: [
            if (icon != null) Icon(icon, color: textPrimary, size: 20),
            Text(
              name,
              style: TextStyle(
                color: textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
