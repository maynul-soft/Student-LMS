import 'package:get/get.dart';
import 'package:lms/cmmon/controller/auth_controller.dart';
import 'package:lms/cmmon/data/network/network_client.dart';
import 'package:lms/cmmon/data/network/urls.dart';
import 'package:logger/logger.dart';
import '../../data/models/resultModel.dart';

class ResultController extends GetxController{

  List<ResultModel> examList = [];
  List<ResultModel> filteredList =[];
  List<ResultModel> onChangeList =[];


  Future<void>getResultListData()async{
    String id = AuthController.userId.toString();
    String password = AuthController.password.toString();

    Map<String, String> fields = {
      'id': id,
      'password': password
    };
    NetworkResponse response = await NetworkClient.multiPartRequest(url: Urls.resultUrl, fields: fields);
    Logger().e(response.listBody![0]);
    if(response.statusCode == 200){
      examList =  (response.listBody![0] as List).map((e)=>ResultModel.fromJson(e)).toList() ;
      // Logger().i(examList[0].name);

      filteredList = examList;
      Logger().i(examList.runtimeType);
    }
  }

  filterData(String value){
    filteredList = examList.where((e)=>e.examName.toLowerCase().contains(value.toLowerCase())).toList();
    update();
  }
  onChange(String value){
    onChangeList = examList.where((e)=>e.examName.toLowerCase().contains(value.toLowerCase())).toList();
    filteredList = onChangeList;
    if(value.isEmpty){
      filteredList = examList;
    }
    update();
  }






}