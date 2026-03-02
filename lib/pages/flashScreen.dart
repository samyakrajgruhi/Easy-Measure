import 'package:easymeasure/pages/homePage.dart';
import 'package:easymeasure/theme/theme.dart';
import 'package:flutter/material.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textPrimary,
      body: Center(
        child: Container(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Easy",
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 60,

                      fontFamily: 'Jua',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Image.asset(
                    'lib/images/icons/content_cut.png',
                    width: 72,
                    height: 72,
                  ),
                ],
              ),
              Text(
                "Measure",
                style: TextStyle(
                  color: Colors.green[300],
                  fontSize: 60,

                  fontFamily: 'Jua',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
