import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'dashboard_screen.dart';
import '../models/user_model.dart';
import '../services/local_storage_service.dart';

class AptitudeScreen extends StatefulWidget {
  const AptitudeScreen({super.key});

  @override
  State<AptitudeScreen> createState() => _AptitudeScreenState();
}

class _AptitudeScreenState extends State<AptitudeScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedOption;
  String level = "Beginner";

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is 5 + 3?",
      "options": ["6", "7", "8", "9"],
      "answer": 2,
    },
    {
      "question": "Which is a vowel?",
      "options": ["B", "C", "A", "D"],
      "answer": 2,
    },
    {
      "question": "What is 10 - 4?",
      "options": ["5", "6", "7", "8"],
      "answer": 1,
    },
  ];

  void nextQuestion() {
    if (selectedOption == null) return;

    if (selectedOption == questions[currentQuestionIndex]["answer"]) {
      score++;
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOption = null;
      });
    } else {
      showResult();
    }
  }

  void showResult() async {
    double percentage = (score / questions.length) * 100;

    if (percentage < 40) {
      level = "Beginner";
    } else if (percentage < 75) {
      level = "Intermediate";
    } else {
      level = "Advanced";
    }

    UserModel user = UserModel(
      name: "Student",
      email: "demo@email.com",
      ageGroup: "10-12",
      grade: "Grade 5",
      level: level,
    );

    await LocalStorageService.saveUser(user);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Test Completed"),
        content: Text(
          "Score: $score / ${questions.length}\nLevel: $level",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
                ),
              );
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Question ${currentQuestionIndex + 1} of ${questions.length}",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              question["question"],
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 30),
            ...List.generate(
              question["options"].length,
              (index) {
                final isSelected = selectedOption == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOption = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.card,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      question["options"][index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedOption != null ? nextQuestion : null,
                child: const Text("Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
