import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lms/app/app.dart';
import 'package:lms/app/utils/app_colors.dart';

import 'package:lms/features/home/ui/screens/home_screen.dart';
import 'package:logger/logger.dart';

import '../../../../common/controller/auth_controller.dart';
import '../../../../common/data/models/log_in_model.dart';
import '../../../../common/data/network/network_client.dart';
import '../../../../common/data/network/urls.dart';


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
    duration: const Duration(seconds: 3),
    snackPosition: SnackPosition.TOP,
    backgroundColor: AppColors.themColor,

   );

  }else{
   await AuthController.saveUserInformation(loginModel: LoginModel.fromJson(response.body!),id: id,pass: password);
   Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, HomeScreen.name, (predicate)=>false);
  }


}
