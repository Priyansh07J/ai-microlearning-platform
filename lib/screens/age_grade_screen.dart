import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'aptitude_screen.dart';

class AgeGradeScreen extends StatefulWidget {
  const AgeGradeScreen({super.key});

  @override
  State<AgeGradeScreen> createState() => _AgeGradeScreenState();
}

class _AgeGradeScreenState extends State<AgeGradeScreen> {
  String? selectedAge;
  String? selectedGrade;

  final List<String> ageGroups = [
    "6-8",
    "9-11",
    "12-14",
    "15-17",
  ];

  final List<String> grades = [
    "Grade 1",
    "Grade 2",
    "Grade 3",
    "Grade 4",
    "Grade 5",
    "Grade 6",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tell us about you")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text("Select Age Group"),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: ageGroups.map((age) {
                final isSelected = selectedAge == age;
                return ChoiceChip(
                  label: Text(age),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  onSelected: (_) {
                    setState(() {
                      selectedAge = age;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            const Text("Select Grade"),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: grades.map((grade) {
                final isSelected = selectedGrade == grade;
                return ChoiceChip(
                  label: Text(grade),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  onSelected: (_) {
                    setState(() {
                      selectedGrade = grade;
                    });
                  },
                );
              }).toList(),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (selectedAge != null && selectedGrade != null)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AptitudeScreen(),
                          ),
                        );
                      }
                    : null,
                child: const Text("Continue"),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
