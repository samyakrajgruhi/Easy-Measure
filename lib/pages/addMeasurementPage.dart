import 'package:flutter/material.dart';
import 'package:easymeasure/theme/theme.dart';
import 'package:easymeasure/components/input_field.dart';

class AddMeasurementPage extends StatelessWidget {
  const AddMeasurementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> upperBodyFields = [
      "Full length FL",
      "Blouse length",
      "Kurti length",
      "Should Sh",
      "Uppar bust",
      "Bust round B",
      "Under bust",
      "Bust to Apex BL",
      "Apex A",
      "Waist round W",
      "Hip round H",
      "Neck to waist N to W",
      "Neck to hip N to H",
      "Sleeve length",
      "Sleeve hole",
      "Biceps",
      "Arm hole",
    ];

    final List<String> lowerBodyFields = [
      "Pant length",
      "Waist to knee",
      "Thai round",
      "Knee round",
      "Ankal round",
      "Crotch",
      "Skirt length",
      "Low waist",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          "Add Measurement",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            // Title Field
            const InputField(
              label: "Title",
              hintText: "Enter measurement title",
              keyboardType: TextInputType.text,
            ),

            const SizedBox(height: 10),

            // UPPER BODY Section
            Text(
              "UPPER BODY",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textSecondary,
              ),
            ),
            ...upperBodyFields.map(
              (field) =>
                  InputField(label: field, keyboardType: TextInputType.number),
            ),

            // Divider
            Divider(
              color: textSecondary.withOpacity(0.3),
              thickness: 1,
              height: 30,
            ),

            // LOWER BODY Section
            Text(
              "LOWER BODY",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textSecondary,
              ),
            ),
            ...lowerBodyFields.map(
              (field) =>
                  InputField(label: field, keyboardType: TextInputType.number),
            ),

            const SizedBox(height: 30),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print('Save measurement');
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appBarColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
