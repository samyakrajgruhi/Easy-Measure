import 'package:flutter/material.dart';
import 'package:easymeasure/pages/flashScreen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/customer.dart';
import 'models/measurement.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(CustomerAdapter());
  Hive.registerAdapter(MeasurementAdapter());

  await Hive.openBox<Customer>('customers');
  await Hive.openBox<Measurement>('measurements');
  await Hive.openBox('customerMeasurements');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FlashScreen(),
    );
  }
}
