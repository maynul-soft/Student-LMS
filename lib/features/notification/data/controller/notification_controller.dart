import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController{

  static NotificationController controller = Get.find<NotificationController>();

  List<RemoteMessage> notificationList = [];
  bool isActive = false ;

   updateNotificationList(RemoteMessage message){
    notificationList.add(message);
    isActive = true;
    update();
  }

  updateNotificationStatus(){
     isActive = false;
     update();
  }


}