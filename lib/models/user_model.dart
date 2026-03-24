class UserModel {
  final String name;
  final String email;
  final String ageGroup;
  final String grade;
  final String level;

  UserModel({
    required this.name,
    required this.email,
    required this.ageGroup,
    required this.grade,
    required this.level,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "ageGroup": ageGroup,
      "grade": grade,
      "level": level,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      email: json["email"],
      ageGroup: json["ageGroup"],
      grade: json["grade"],
      level: json["level"],
    );
  }
}
