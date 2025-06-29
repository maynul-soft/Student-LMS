import 'package:get/get.dart';
import 'package:lms/cmmon/controller/auth_controller.dart';
import 'package:lms/cmmon/data/network/network_client.dart';
import 'package:lms/cmmon/data/network/urls.dart';
import 'package:lms/features/upcoming_exam/data/models/upcoming_exam_model.dart';
import 'package:logger/logger.dart';

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