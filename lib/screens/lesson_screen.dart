import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LessonScreen extends StatefulWidget {
  final String title;

  const LessonScreen({super.key, required this.title});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int currentQuestionIndex = 0;
  int? selectedOption;
  bool showResult = false;
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is 5 + 3?",
      "options": ["6", "7", "8", "9"],
      "answer": 2,
    },
    {
      "question": "What is 10 - 2?",
      "options": ["6", "7", "8", "9"],
      "answer": 2,
    },
    {
      "question": "What is 4 x 2?",
      "options": ["6", "8", "10", "12"],
      "answer": 1,
    },
  ];

  void submitAnswer() {
    if (selectedOption == null) return;

    setState(() {
      showResult = true;
      if (selectedOption == questions[currentQuestionIndex]["answer"]) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOption = null;
        showResult = false;
      });
    } else {
      showCompletion();
    }
  }

  void showCompletion() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Lesson Completed 🎉"),
        content: Text("Your Score: $score / ${questions.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Back to Dashboard"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    double progress = (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          /// 🔵 HEADER
          Container(
            height: 180,
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4B5EFF),
                  Color(0xFF6A5AE0),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 10),

                /// 📊 PROGRESS BAR
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white30,
                  color: Colors.white,
                ),
              ],
            ),
          ),

          /// 📘 CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// QUESTION
                  Text(
                    "Question ${currentQuestionIndex + 1}",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    question["question"],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// OPTIONS
                  ...List.generate(
                    question["options"].length,
                    (index) {
                      bool isSelected = selectedOption == index;
                      bool isCorrect = index == question["answer"];

                      Color color = AppColors.card;

                      if (showResult) {
                        if (isCorrect) {
                          color = Colors.green;
                        } else if (isSelected) {
                          color = Colors.red;
                        }
                      } else if (isSelected) {
                        color = AppColors.primary;
                      }

                      return GestureDetector(
                        onTap: () {
                          if (!showResult) {
                            setState(() {
                              selectedOption = index;
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            question["options"][index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const Spacer(),

                  /// BUTTONS
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: selectedOption == null
                          ? null
                          : (showResult ? nextQuestion : submitAnswer),
                      child: Text(
                        showResult ? "Next" : "Submit",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
