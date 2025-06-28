import 'package:get/get.dart';
import 'package:lms/cmmon/controller/auth_controller.dart';
import 'package:lms/features/attandence/controller/attendance_controller.dart';
class ControllerBinder extends Bindings {
  @override
  void dependencies() {
   Get.put(AuthController());
   Get.put(AttendanceController());
  }
}