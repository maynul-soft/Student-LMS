import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/app/app.dart';
import 'package:logger/logger.dart';
import '../../../common/controller/auth_controller.dart';
import '../../../common/data/network/network_client.dart';
import '../../../common/data/network/urls.dart';
import '../data/models/attandence_model.dart';
import '../data/models/attendace_report_model.dart';


class AttendanceController extends GetxController {
  static AttendanceController controller = Get.find<AttendanceController>();

  String? startDate, endDate;

  List<AttendanceModel> attendances = [];

  DateTime now = DateTime.now();
  DateTime oneMonthAgo = DateTime.now().subtract(const Duration(days: 30));
  DateTime firstDate = DateTime(2000);
  DateTime lastDate = DateTime(2100);
  DateTime initialDate = DateTime.now();


  Future<void> pickDate ({required bool isStartDate}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: navigatorKey.currentContext!,
      initialDate: isStartDate? stringToDateTime(startDate!):stringToDateTime(endDate!),
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (pickedDate != null) {
      final formatted = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      if (isStartDate) {
        startDate = formatted;
      } else {
        endDate = formatted;
      }
      update(); // for GetBuilder
    }
  }

  DateTime stringToDateTime(String date) {
    List<String> parts = date.split('-');
    
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    
    if (year < 100) {
      year += 2000;
    }

    return DateTime(year, month, day);
  }


  Future<void> attendanceService() async {
    try {
      if(startDate== null && endDate == null){
        startDate = '${oneMonthAgo.day}-${oneMonthAgo.month}-${oneMonthAgo.year}';
        endDate = '${now.day}-${now.month}-${now.year}';
      }

      String id = AuthController.userId!;
      String password = AuthController.password!;

      Map<String, String> fields = {
        'id': id,
        'password': password,
        'start': startDate!,
        'end': endDate!,
      };

      NetworkResponse response = await NetworkClient.multiPartRequest(
          url: Urls.attendanceUrl, fields: fields);

      if (response.statusCode == 200) {
        AttendanceReportModel attendanceReportModel =
            AttendanceReportModel.fromJson(response.body!);
        attendances = attendanceReportModel.attendances;
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
