class ProgressModel {
  final String lessonTitle;
  final int score;
  final int total;
  final bool completed;

  ProgressModel({
    required this.lessonTitle,
    required this.score,
    required this.total,
    required this.completed,
  });

  Map<String, dynamic> toJson() {
    return {
      "lessonTitle": lessonTitle,
      "score": score,
      "total": total,
      "completed": completed,
    };
  }

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      lessonTitle: json["lessonTitle"],
      score: json["score"],
      total: json["total"],
      completed: json["completed"],
    );
  }
}
