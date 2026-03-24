import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'theme/app_theme.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const MicroLearningApp());
}

class MicroLearningApp extends StatelessWidget {
  const MicroLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Micro Learning',
      theme: AppTheme.darkTheme,
      home: const OnboardingScreen(),
    );
  }
}
