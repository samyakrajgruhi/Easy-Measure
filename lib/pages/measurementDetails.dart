import 'package:easymeasure/models/measurement.dart';
import 'package:flutter/material.dart';
import 'package:easymeasure/theme/theme.dart';

class MeasurementDetails extends StatelessWidget {
  final Measurement measurement;
  const MeasurementDetails({super.key, required this.measurement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          "Measurement Details",
          style: TextStyle(
            color: textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textPrimary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text(
          "Measurement Details Page",
          style: TextStyle(fontSize: 18, color: textSecondary),
        ),
      ),
    );
  }
}
