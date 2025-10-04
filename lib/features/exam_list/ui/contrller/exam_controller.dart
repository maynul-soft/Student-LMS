import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../../common/controller/auth_controller.dart';
import '../../../../common/data/network/network_client.dart';
import '../../../../common/data/network/urls.dart';
import '../../data/models/exam_model.dart';
import 'package:hive/hive.dart';

class ExamController extends GetxController {
  List<ExamModel> examList = [];
  List<ExamModel> filteredList = [];
  List<ExamModel> onChangeList = [];
  String boxKey = 'examList';
  bool isLoading = false;

  Future<void> getExamListData() async {
    await Hive.openBox(boxKey);

    var box = Hive.box(boxKey);

    String? savedData = box.get(boxKey);

    if (savedData != null && savedData != 'null') {
      var decodedData = jsonDecode(savedData!);
      examList =
          (decodedData![0] as List).map((e) => ExamModel.fromJson(e)).toList();
      update();
    }

    if (savedData == null) {
      isLoading = true;
      update();
    }

    String id = AuthController.userId.toString();
    String password = AuthController.password.toString();

    Map<String, String> fields = {'id': id, 'password': password};
    NetworkResponse response = await NetworkClient.multiPartRequest(
        url: Urls.examListUrl, fields: fields);
    Logger().e(response.listBody?[0] ?? '');

    if (response.statusCode == 200 && savedData != jsonEncode(response.body)) {
      box.put(boxKey, jsonEncode(response.body));

      examList = (response.listBody![0] as List)
          .map((e) => ExamModel.fromJson(e))
          .toList();
      // Logger().i(examList[0].name);

      filteredList = examList;
      Logger().i(examList.runtimeType);
      update();
    }

    isLoading = false;
    update();
  }

  filterData(String value) {
    filteredList = examList
        .where((e) => e.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    update();
  }

  onChange(String value) {
    onChangeList = examList
        .where((e) => e.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    filteredList = onChangeList;
    if (value.isEmpty) {
      filteredList = examList;
    }
    update();
  }
}
