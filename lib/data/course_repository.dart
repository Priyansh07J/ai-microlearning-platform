import '../models/course_model.dart';

class CourseRepository {
  static List<CourseModel> getCoursesByLevel(String level) {
    List<CourseModel> allCourses = [
      // Beginner
      CourseModel(title: "Basic Mathematics", progress: 0.2, level: "Beginner"),
      CourseModel(title: "Basic English", progress: 0.1, level: "Beginner"),
      CourseModel(
          title: "Introduction to Science", progress: 0.3, level: "Beginner"),

      // Intermediate
      CourseModel(title: "Algebra", progress: 0.5, level: "Intermediate"),
      CourseModel(
          title: "Grammar Skills", progress: 0.4, level: "Intermediate"),
      CourseModel(
          title: "Physics Basics", progress: 0.6, level: "Intermediate"),

      // Advanced
      CourseModel(title: "Advanced Calculus", progress: 0.7, level: "Advanced"),
      CourseModel(
          title: "Literature Analysis", progress: 0.8, level: "Advanced"),
      CourseModel(
          title: "Advanced Chemistry", progress: 0.9, level: "Advanced"),
    ];

    return allCourses.where((course) => course.level == level).toList();
  }
}
