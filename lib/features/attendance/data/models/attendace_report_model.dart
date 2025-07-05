import 'attandence_model.dart';

class AttendanceReportModel {
  final String status;
  final List<AttendanceModel> attendances;

  AttendanceReportModel({
    required this.status,
    required this.attendances,
  });

  factory AttendanceReportModel.fromJson(Map<String, dynamic> json) {
    return AttendanceReportModel(
      status: json['status'] ?? '',
      attendances: (json['attendances'] as List<dynamic>)
          .map((e) => AttendanceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'attendances': attendances.map((e) => e.toJson()).toList(),
    };
  }
}
