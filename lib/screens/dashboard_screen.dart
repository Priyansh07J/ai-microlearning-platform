import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/local_storage_service.dart';
import '../models/user_model.dart';
import '../models/course_model.dart';
import '../models/progress_model.dart';
import '../data/course_repository.dart';
import 'course_detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserModel? currentUser;
  List<CourseModel> recommendedCourses = [];
  List<ProgressModel> progressList = [];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadUser();
    loadProgress();
  }

  /// LOAD USER
  void loadUser() async {
    final user = await LocalStorageService.getUser();

    if (!mounted) return;

    setState(() {
      currentUser = user;
      if (user != null) {
        recommendedCourses = CourseRepository.getCoursesByLevel(user.level);
      }
    });
  }

  /// LOAD PROGRESS
  void loadProgress() async {
    final data = await LocalStorageService.getProgress();

    if (!mounted) return;

    setState(() {
      progressList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: selectedIndex == 0
          ? buildHome()
          : selectedIndex == 1
              ? buildCourses()
              : buildProfile(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.card,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // ================= HOME =================

  Widget buildHome() {
    return Stack(
      children: [
        Container(
          height: 240,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4B5EFF), Color(0xFF6A5AE0)],
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hi, ${currentUser?.name ?? "Student"} 👋",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.black),
                    )
                  ],
                ),

                const SizedBox(height: 40),

                /// LEVEL CARD
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Your Level",
                          style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 10),
                      Text(
                        currentUser?.level ?? "Beginner",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                /// RECOMMENDED
                const Text(
                  "Recommended",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: recommendedCourses.map((course) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: CourseCard(
                          title: course.title,
                          progress: course.progress,
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 30),

                /// 🔥 PROGRESS SECTION
                const Text(
                  "Your Progress",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 15),

                if (progressList.isEmpty)
                  const Text(
                    "No progress yet",
                    style: TextStyle(color: Colors.grey),
                  )
                else
                  ...progressList.map((p) {
                    double percent = p.score / p.total;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.lessonTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: percent,
                            backgroundColor: Colors.grey.shade800,
                            valueColor:
                                AlwaysStoppedAnimation(AppColors.primary),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${p.score}/${p.total}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ================= COURSES =================

  Widget buildCourses() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        title: const Text("All Courses"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: recommendedCourses.map((course) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: VerticalCourseCard(
              title: course.title,
              progress: course.progress,
            ),
          );
        }).toList(),
      ),
    );
  }

  // ================= PROFILE =================

  Widget buildProfile() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Text(
              currentUser?.name ?? "",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(currentUser?.email ?? "",
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

/// ================= COURSE CARD =================

class CourseCard extends StatelessWidget {
  final String title;
  final double progress;

  const CourseCard({
    super.key,
    required this.title,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailScreen(title: title),
          ),
        );
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.menu_book, color: Colors.blue),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade800,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= VERTICAL CARD =================

class VerticalCourseCard extends StatelessWidget {
  final String title;
  final double progress;

  const VerticalCourseCard({
    super.key,
    required this.title,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade800,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
