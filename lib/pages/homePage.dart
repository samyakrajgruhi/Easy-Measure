import 'package:flutter/material.dart';
import 'package:easymeasure/theme/theme.dart';
import 'package:easymeasure/components/name_plate.dart';
import 'package:easymeasure/pages/addCustomerPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> names = [
      'Nirmala Rajgruhi',
      'Kalpana Kumari',
      'Kavita Kumari',
      'Shakshi Patel',
      'Guljari Prasad',
      'Harshita Ben',
      'Anjali Sharma',
      'Priya Singh',
      'Meera Reddy',
      'Sunita Gupta',
      'Rekha Joshi',
      'Pooja Verma',
      'Divya Nair',
      'Lakshmi Iyer',
      'Radha Pillai',
      'Geeta Devi',
      'Shalini Rao',
      'Usha Menon',
      'Vidya Kulkarni',
      'Deepa Mishra',
    ];

    names.sort((a, b) => a.compareTo(b));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Center(
          child: Text(
            "Easy Measure",
            style: TextStyle(
              color: textPrimary,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by Name',
                hintStyle: TextStyle(color: textSecondary.withOpacity(0.6)),
                filled: true,
                fillColor: inputField,
                suffixIcon: Icon(
                  Icons.search,
                  color: textSecondary.withOpacity(0.6),
                ),
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
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return NamePlate(
                    name: names[index],
                    onTap: () {
                      print('Tapped on ${names[index]}');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCustomerPage()),
          );
        },
        backgroundColor: inputField,
        child: const Icon(Icons.add, color: textSecondary, size: 32),
      ),
    );
  }
}
