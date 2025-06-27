import 'dart:convert';

import 'package:get/get.dart';
import 'package:lms/cmmon/data/models/log_in_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static final AuthController controller = Get.find<AuthController>();

  static LoginModel? studentInfo;

  static final Logger _logger = Logger();

  static const String _studentInfoKey = 'user-data';

  static Future<void> saveUserInformation(
    LoginModel loginModel,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(
        _studentInfoKey, jsonEncode(loginModel.toJson()));

    _logger.w('Data Saved');

    studentInfo = loginModel;

    _logger.i("This Is Save Data: $studentInfo");
    Get.find<AuthController>().update();
  }

  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? savedUserModelString = sharedPreferences.getString(_studentInfoKey);

    if (savedUserModelString != null) {
      LoginModel userModel = LoginModel.fromJson(
        jsonDecode(savedUserModelString),
      );
      studentInfo = userModel;
    }
    if (studentInfo?.data.studentName != null) {
      _logger.w('User Got the data successfully');
    }
    Get.find<AuthController>().update();
  }
}
