import 'package:flutter/material.dart';
import 'package:lms/features/attandence/ui/screens/attendace_screen.dart';
import 'package:lms/features/auth/ui/screens/login_screen.dart';
import 'package:lms/features/home/ui/screens/home_screen.dart';
import 'package:lms/features/upcoming_exam/ui/screens/upcoming_exam_screen.dart';
import '../../features/auth/ui/screens/splash_screen.dart';

class AppRoutes{
  static Route<dynamic> routes (RouteSettings setting) {
    late final Widget screenWidgets;
    if (setting.name == SplashScreen.name) {
      screenWidgets = const SplashScreen();
    }else if(setting.name == LoginScreen.name){
      screenWidgets = const LoginScreen();
    }else if(setting.name ==  UpcomingExamScreen.name ){
      screenWidgets = const UpcomingExamScreen();
    }else if(setting.name ==  HomeScreen.name ){
      screenWidgets = const HomeScreen();
    }else if(setting.name ==  AttendanceScreen.name ){
      screenWidgets = const AttendanceScreen();
    }
    return MaterialPageRoute(builder: (context) => screenWidgets);
  }
}