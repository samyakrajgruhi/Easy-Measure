import 'package:flutter/material.dart';
import 'package:easymeasure/theme/theme.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType? keyboardType;

  const InputField({
    super.key,
    required this.label,
    this.hintText = 'Enter value',
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: textSecondary,
          ),
        ),
        TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: textSecondary.withOpacity(0.6)),
            filled: true,
            fillColor: inputField,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
