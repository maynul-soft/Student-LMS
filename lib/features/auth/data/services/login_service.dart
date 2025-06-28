import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lms/app/app.dart';
import 'package:lms/cmmon/controller/auth_controller.dart';
import 'package:lms/cmmon/data/models/log_in_model.dart';
import 'package:lms/cmmon/data/network/network_client.dart';
import 'package:lms/cmmon/data/network/urls.dart';
import 'package:lms/features/home/ui/screens/home_screen.dart';

 Future<void> loginService(
    {required String id, required String password}) async {
  NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.loginUrl(id: id, password: password));
  debugPrint('FromLogInScreen: ${response.body}');

  if(response.body!["status"] == 'success'){
  await AuthController.saveUserInformation(loginModel: LoginModel.fromJson(response.body!),id: id,pass: password);
  }
  
  Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, HomeScreen.name, (predicate)=>false);

}
