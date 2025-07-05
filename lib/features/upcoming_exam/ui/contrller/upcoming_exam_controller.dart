import 'package:get/get.dart';
import 'package:lms/features/upcoming_exam/data/models/upcoming_exam_model.dart';
import 'package:logger/logger.dart';

import '../../../../common/controller/auth_controller.dart';
import '../../../../common/data/network/network_client.dart';
import '../../../../common/data/network/urls.dart';

class UpcomingExamController extends GetxController{

  List<UpcomingExamModel> upcomingExamList = [];

  Future<void>getUpcomingExamData()async{
    String id = AuthController.userId.toString();
    String password = AuthController.password.toString();

    Map<String, String> fields = {
      'id': id,
      'password': password
    };
    NetworkResponse response = await NetworkClient.multiPartRequest(url: Urls.upcomingExamUrl, fields: fields);
    if(response.statusCode == 200){
      upcomingExamList =  response.listBody!.map((e)=>UpcomingExamModel.fromJson(e)).toList();
      Logger().i(upcomingExamList[0].name);
    }
  }
}