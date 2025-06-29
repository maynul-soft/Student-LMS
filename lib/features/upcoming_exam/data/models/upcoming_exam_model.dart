class UpcomingExamModel {
  final String name;
  final String course;
  final String duration;
  final String date;
  final String syllabus;

  UpcomingExamModel({
    required this.name,
    required this.course,
    required this.duration,
    required this.date,
    required this.syllabus,
  });

  factory UpcomingExamModel.fromJson(Map<String, dynamic> json) {
    return UpcomingExamModel(
      name: json['name'] ?? '',
      course: json['course'] ?? '',
      duration: json['duration'] ?? '',
      date: json['date'] ?? '',
      syllabus: json['syllabus'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'course': course,
      'duration': duration,
      'date': date,
      'syllabus': syllabus,
    };
  }
}
