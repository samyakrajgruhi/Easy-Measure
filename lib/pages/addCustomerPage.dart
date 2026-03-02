import 'package:easymeasure/pages/addMeasurementPage.dart';
import 'package:flutter/material.dart';
import 'package:easymeasure/theme/theme.dart';

class AddCustomerPage extends StatelessWidget {
  const AddCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          "Add Customer",
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
          spacing: 15,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  "Name",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
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
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Phone Number',
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
            ),

            Divider(color: textSecondary.withOpacity(0.3), thickness: 1),

            Text(
              "No measurements Saved",
              style: TextStyle(
                fontSize: 18,
                color: textSecondary.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(
              width: 56,
              height: 56,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMeasurementPage(),
                    ),
                  );
                },
                backgroundColor: appBarColor,
                child: const Icon(Icons.add, color: textPrimary, size: 32),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print('Save customer');
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
