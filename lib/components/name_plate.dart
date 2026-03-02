import 'package:flutter/material.dart';
import 'package:easymeasure/theme/theme.dart';

class NamePlate extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const NamePlate({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: appBarColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
