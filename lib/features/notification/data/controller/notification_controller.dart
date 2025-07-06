import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController{

  static NotificationController controller = Get.find<NotificationController>();

  List<RemoteMessage> notificationList = [];
  bool isActive = false ;
  final String saveNotificationKey = 'saveNotification';

   updateNotificationList(RemoteMessage message){
    notificationList.add(message);
    isActive = true;
    update();
    saveNotification();
    getNotification();
  }

  updateNotificationStatus(){
     isActive = false;
     update();
  }


  saveNotification() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Only store necessary parts of RemoteMessage
    List<Map<String, dynamic>> encodedList = notificationList.map((msg) {
      return {
        'title': msg.notification?.title ?? '',
        'body': msg.notification?.body ?? '',
        'data': msg.data,
      };
    }).toList();

    // Limit to 10 messages
    if (encodedList.length > 10) {
      encodedList = encodedList.sublist(1, 11);
    }

    await sharedPreferences.setString(saveNotificationKey, jsonEncode(encodedList));
    Logger().i("Notifications saved");
  }


  getNotification() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? stringNotification = sharedPreferences.getString(saveNotificationKey);

    if (stringNotification != null) {
      List decodedList = jsonDecode(stringNotification);

      // Rebuild list from saved data
      notificationList = decodedList.map((item) {
        return RemoteMessage(
          data: Map<String, dynamic>.from(item['data']),
          notification: RemoteNotification(
            title: item['title'],
            body: item['body'],
          ),
        );
      }).toList();

      Logger().i("Notifications loaded from local");
      update();
    } else {
      Logger().i("No saved notifications");
    }
  }



}