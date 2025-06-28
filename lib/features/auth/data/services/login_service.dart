import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:lms/app/app.dart';
import 'package:lms/app/utils/app_colors.dart';
import 'package:lms/cmmon/controller/auth_controller.dart';
import 'package:lms/cmmon/data/models/log_in_model.dart';
import 'package:lms/cmmon/data/network/network_client.dart';
import 'package:lms/cmmon/data/network/urls.dart';
import 'package:lms/features/home/ui/screens/home_screen.dart';
import 'package:logger/logger.dart';


 Future<void> loginService(
    {required String id, required String password}) async {
  NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.loginUrl(id: id, password: password));

  debugPrint('FromLogInScreen: ${response.body}');

  Logger().e(response.body!["status"]);


  if(response.body!["status"] != 'success'){
   Get.snackbar(
       'Login Failed..!',
       response.body!["message"],
    duration: Duration(seconds: 3),
    snackPosition: SnackPosition.TOP,
    backgroundColor: AppColors.themColor,

   );

  }else{
   await AuthController.saveUserInformation(loginModel: LoginModel.fromJson(response.body!),id: id,pass: password);
   Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, HomeScreen.name, (predicate)=>false);
  }


}
