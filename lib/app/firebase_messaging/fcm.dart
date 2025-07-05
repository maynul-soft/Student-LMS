import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lms/app/app.dart';
import 'package:lms/common/controller/auth_controller.dart';
import 'package:lms/features/notification/data/controller/notification_controller.dart';
import 'package:lms/features/notification/ui/screens/notification_screen.dart';
import 'package:logger/logger.dart';

class Fcm {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String? token;
  RemoteMessage? notifications;

  Future<void> getNotification() async {

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );


    notifications = await messaging.getInitialMessage();
    Logger().i('Notifications => $notifications');


    await subscribe();

    FirebaseMessaging.onMessage.listen(_handelForegroundNotification);

    FirebaseMessaging.onMessageOpenedApp.listen(_handelNotification);

    FirebaseMessaging.onBackgroundMessage(handelBackgroundNotification);

    token = await messaging.getToken();
    messaging.onTokenRefresh.listen((newToken) => token = newToken);
    Logger().i(token);
  }

  void _handelNotification(RemoteMessage message) {
    Logger().i('''
      ${message.notification?.title}
      ${message.notification?.body}
      ''');
    NotificationController.controller.updateNotificationList(message);

    navigatorKey.currentState?.pushNamed(NotificationScreen.name);
  }

  void _handelForegroundNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
              android: AndroidNotificationDetails(
                  'default_channel',
                  'General',
                  importance: Importance.max,
                  priority: Priority.high,

              ),),
      payload: NotificationScreen.name
      );
    }

    NotificationController.controller.updateNotificationList(message);

    Logger().i('''
    Foreground Notification:
    ${message.notification?.title}
    ${message.notification?.body}
    ''');
  }

  subscribe() async {
    bool isSubscribed = await AuthController.checkSubscribeNotification();

    if (!isSubscribed) {
      await AuthController.subscribeNotification(messaging);
      Logger().e('Subscription successfully');
    } else {
      Logger().e('Already Subscribed');
    }
  }


}

@pragma('vm:entry-point')
Future<void> handelBackgroundNotification(RemoteMessage message) async {
  Logger().i(message);
  Navigator.pushNamed(navigatorKey.currentContext!, NotificationScreen.name);
  NotificationController.controller.updateNotificationList(message);
}
