import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging_platform_interface/src/remote_notification.dart' show RemoteNotification;
import 'package:flutter/material.dart';
import 'package:lms/app/utils/app_colors.dart';
import 'package:lms/features/notification/data/controller/notification_controller.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static const String name = 'notification-screen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController notificationController =
      Get.find<NotificationController>();


  @override
  void initState() {
    super.initState();

    updateNotificationStatus();
  }

  Future<void> updateNotificationStatus()async{
   await  Future.delayed(const Duration(seconds: 1));
   notificationController.updateNotificationStatus();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themColor,
        title: const Text('Notifications'),
      ),
      body: notificationController.notificationList.isEmpty
          ?const Center(
              child: Text('No Notification'),
            )
          : GetBuilder<NotificationController>(builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ListView.builder(
                  itemCount: controller.notificationList.length,
                  itemBuilder: ((BuildContext context, index) {
                    var notification = controller.notificationList[index].notification!;
                    return buildNotificationCard(notification);
                  }),
                ),
              );
            }),
    );
  }

  Widget buildNotificationCard(RemoteNotification notification) {
    return Card(
      elevation: 5,
                    color: Colors.grey.shade100,
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.notifications_active,color: Colors.white,)),
                      title: Text(
                        notification.title!,
                        style: const TextStyle(
                          color: Colors.black,
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        notification.body!,
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                    ),
                  );
  }

  // int manageIndex(int index, int length) {
  //   int result = length - (index+1);
  //
  //   if (result <= 1) return 0;
  //   if (result > 9) return 9;
  //   return result;
  // }

}
