class AttendanceModel {
  final String date;
  final String attendance;
  final String textColor;

  AttendanceModel({
    required this.date,
    required this.attendance,
    required this.textColor,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      date: json['date'],
      attendance: json['attendance'],
      textColor: json['text_color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'attendance': attendance,
      'text_color': textColor,
    };
  }
}
