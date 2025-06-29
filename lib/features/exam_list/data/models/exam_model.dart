class ExamModel {
  final String name;
  final String course;
  final String duration;
  final String date;
  final String status;
  final String syllabus;

  ExamModel({
    required this.name,
    required this.course,
    required this.duration,
    required this.date,
    required this.status,
    required this.syllabus,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      name: json['name'] ?? '',
      course: json['course'] ?? '',
      duration: json['duration'] ?? '',
      date: json['date'] ?? '',
      status: json['status'] ?? '',
      syllabus: json['syllabus'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'course': course,
      'duration': duration,
      'date': date,
      'status': status,
      'syllabus': syllabus,
    };
  }
}
