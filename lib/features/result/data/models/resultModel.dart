class ResultModel {
  final String examName;
  final String paperMark;
  final int totalMark;
  final int obtainedMark;
  final double average;
  final String grade;

  ResultModel({
    required this.examName,
    required this.paperMark,
    required this.totalMark,
    required this.obtainedMark,
    required this.average,
    required this.grade,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      examName: json['exam_name'] ?? '',
      paperMark: json['paper_mark'] ?? '',
      totalMark: json['total_mark'] ?? 0,
      obtainedMark: json['obtained_mark'] ?? 0,
      average: (json['average'] ?? 0).toDouble(),
      grade: json['grade'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exam_name': examName,
      'paper_mark': paperMark,
      'total_mark': totalMark,
      'obtained_mark': obtainedMark,
      'average': average,
      'grade': grade,
    };
  }
}
