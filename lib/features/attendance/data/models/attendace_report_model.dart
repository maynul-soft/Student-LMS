import 'attandence_model.dart';

class AttendanceReportModel {
  final String status;
  final List<AttendanceModel> attendances;

  AttendanceReportModel({
    required this.status,
    required this.attendances,
  });

  factory AttendanceReportModel.fromJson(Map<String, dynamic> json) {
    List x = (json['attendances']);
    return AttendanceReportModel(
      status: json['status'] ?? '',

      attendances: x
          .map((e) => AttendanceModel.fromJson(e))
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
