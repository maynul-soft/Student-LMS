import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lms/features/notification/ui/screens/notification_screen.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/app.dart';

class NotificationController extends GetxController {
  static NotificationController controller = Get.find<NotificationController>();

  final Logger  _logger = Logger();

  List<RemoteMessage> notificationList = [];

  bool isActive = false;
  bool isNotificationState = false;

  setNotificationStateTrue(){
    isNotificationState = true;
    _logger.w(isNotificationState);
  }
  setNotificationStateFalse(){
    isNotificationState = false;
    _logger.w(isNotificationState);
  }


  final String saveNotificationKey = 'saveNotification';

  updateNotificationList(RemoteMessage message) {

    if(!isNotificationState) {
      isActive = true;
      Logger().e('I am not working');
    }
    notificationList.add(message);
    saveNotification();
    getNotification();
    update();
  }

  updateNotificationStatus() {
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
        'path':
            msg.notification?.android?.clickAction ?? NotificationScreen.name
      };
    }).toList();

    // Limit to 10 messages
    if (encodedList.length > 10) {
      encodedList = encodedList.sublist(1, 11);
    }

    await sharedPreferences.setString(
        saveNotificationKey, jsonEncode(encodedList));
    Logger().i("Notifications saved");
  }

  getNotification() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? stringNotification =
        sharedPreferences.getString(saveNotificationKey);

    if (stringNotification != null) {
      List decodedList = jsonDecode(stringNotification);

      // Rebuild list from saved data
      List<RemoteMessage> tempLIst = decodedList.map((item) {
        return RemoteMessage(
          data: Map<String, dynamic>.from(item['data']),
          notification: RemoteNotification(
            title: item['title'],
            body: item['body'],
          ),
        );
      }).toList();

      notificationList = tempLIst.reversed.toList();

      update();

      Logger().i("Notifications loaded from local");
    } else {
      Logger().i("No saved notifications");
    }
  }
}
