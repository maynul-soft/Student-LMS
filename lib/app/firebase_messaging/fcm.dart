import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lms/app/app.dart';
import 'package:lms/common/controller/auth_controller.dart';
import 'package:lms/features/home/ui/screens/home_screen.dart';
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
    // Request notification permissions for all platforms once.
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Get the FCM token and listen for refreshes immediately after permission.
    // This is crucial for both iOS and Android.
    token = await messaging.getToken();
    if (token != null) {
      Logger().i('FCM Token: $token');
    } else {
      Logger().w('FCM Token is null. Check your configuration.');
    }

    // Listen for token refreshes
    messaging.onTokenRefresh.listen((newToken) {
      token = newToken;
      Logger().i('FCM Token refreshed: $token');
    });

    notifications = await messaging.getInitialMessage();
    Logger().i('Notifications => $notifications');

    await subscribe();

    // Set up listeners for messages after the token has been fetched.
    FirebaseMessaging.onMessage.listen(_handelForegroundNotification);

    FirebaseMessaging.onMessageOpenedApp.listen(_handelNotification);

    FirebaseMessaging.onBackgroundMessage(handelBackgroundNotification);
  }

  void _handelNotification(RemoteMessage message) {
    Logger().i('''
      ${message.notification?.title}
      ${message.notification?.body} 
      ''');
    NotificationController.controller.updateNotificationList(message);

    navigatorKey.currentState?.pushNamed(HomeScreen.name);
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
          ),
        ),
        payload: NotificationController.controller.isNotificationState == false
            ? NotificationScreen.name
            : HomeScreen.name,
      );
    }

    NotificationController.controller.updateNotificationList(message);

    Logger().w('''
    Foreground Notification:
    ${message.notification?.title}
    ${message.notification?.body}
    ${message.notification?.android!.clickAction}
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
  Navigator.pushNamed(navigatorKey.currentContext!, HomeScreen.name);
  NotificationController.controller.updateNotificationList(message);
}