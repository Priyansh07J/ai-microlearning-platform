import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'lesson_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final String title;

  const CourseDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// HEADER
            Container(
              height: 250,
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF4B5EFF),
                    Color(0xFF6A5AE0),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Icon(Icons.favorite_border, color: Colors.white),
                ],
              ),
            ),

            /// CONTENT
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "6h 14min • 24 Lessons",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  /// ABOUT
                  const Text(
                    "About this course",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "This course will help you build strong fundamentals and improve your practical skills step by step.",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 30),

                  /// LESSONS
                  const Text(
                    "Lessons",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 15),

                  buildLessonTile(context, "01", "Introduction", "6:10 mins"),
                  buildLessonTile(context, "02", "Core Concepts", "8:20 mins"),
                  buildLessonTile(
                      context, "03", "Practice Session", "10:05 mins"),

                  const SizedBox(height: 40),

                  /// BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const LessonScreen(title: "Introduction"),
                          ),
                        );
                      },
                      child: const Text("Start Learning"),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// LESSON TILE FUNCTION
  Widget buildLessonTile(
    BuildContext context,
    String number,
    String title,
    String duration,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LessonScreen(title: title),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Text(
              number,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              duration,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.play_circle_fill, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
