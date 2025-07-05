import 'package:get/get.dart';
import 'package:lms/features/exam_list/ui/contrller/exam_controller.dart';
import 'package:lms/features/notification/data/controller/notification_controller.dart';
import 'package:lms/features/result/ui/contrller/result_controller.dart';
import 'package:lms/features/upcoming_exam/ui/contrller/upcoming_exam_controller.dart';

import '../common/controller/auth_controller.dart';
import '../features/attendance/controller/attendance_controller.dart';
class ControllerBinder extends Bindings {
  @override
  void dependencies() {
   Get.put(AuthController());
   Get.put(AttendanceController());
   Get.put(UpcomingExamController());
   Get.put(ExamController());
   Get.put(ResultController());
   Get.put(NotificationController());
  }
}