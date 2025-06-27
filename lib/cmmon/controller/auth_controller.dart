import 'dart:convert';

import 'package:get/get.dart';
import 'package:lms/cmmon/data/models/log_in_model.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static final AuthController controller = Get.find<AuthController>();

  static LoginModel? studentInfo;
  static String? userId, password;

  static final Logger _logger = Logger();

  static const String _studentInfoKey = 'user-data';
  static const String _userIdKey = 'user-id';
  static const String _passwordKey = 'password';

  static Future<void> saveUserInformation(
      {required LoginModel loginModel,
      required String id,
      required String pass}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(_userIdKey, id);
    sharedPreferences.setString(_passwordKey, pass);
    sharedPreferences.setString(
        _studentInfoKey, jsonEncode(loginModel.toJson()));

    _logger.w('Data Saved');

    studentInfo = loginModel;
    userId = id;
    password = pass;

    _logger.i("This Is Save Data: $studentInfo");

    Get.find<AuthController>().update();
  }

  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? savedUserModelString = sharedPreferences.getString(_studentInfoKey);
    String? id = sharedPreferences.getString(_userIdKey);
    String? pass = sharedPreferences.getString(_passwordKey);

    if (savedUserModelString != null && id!= null && pass != null) {
      LoginModel userModel = LoginModel.fromJson(
        jsonDecode(savedUserModelString),
      );
      studentInfo = userModel;
      userId = id;
      password = pass;
    }
    if (studentInfo?.data.studentName != null) {
      _logger.w('User Got the data successfully');
    }
    Get.find<AuthController>().update();
  }

  static  Future<bool> checkIsUseLoggedIn() async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    String? id =  sharedPreferences.getString(_userIdKey);
    String? pass =  sharedPreferences.getString(_passwordKey);

    _logger.i('id: $id, pass: $pass');
    if (id != null && pass != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future logOut()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();

    sharedPreferences.clear();
    userId = null;
    password = null;
    studentInfo = null;

    _logger.i('Token: ==> $userId & cleared');
    _logger.i('Token: ==> $password & cleared');
    _logger.i('Token: ==> $studentInfo & cleared');
  }

}
