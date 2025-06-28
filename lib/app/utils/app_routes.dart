import 'package:flutter/material.dart';
import 'package:lms/features/auth/ui/screens/login_screen.dart';
import 'package:lms/features/gallery/ui/screens/gallery_screen.dart';
import 'package:lms/features/home/ui/screens/home_screen.dart';
import 'package:lms/features/syllabus/ui/screens/syllabus_screen.dart';
import '../../features/auth/ui/screens/splash_screen.dart';

class AppRoutes{
  static Route<dynamic> routes (RouteSettings setting) {
    late final Widget screenWidgets;
    if (setting.name == SplashScreen.name) {
      screenWidgets = const SplashScreen();
    }else if(setting.name == LoginScreen.name){
      screenWidgets = const LoginScreen();
    }else if(setting.name == GalleryScreen.name){
      screenWidgets = const GalleryScreen();
    }else if(setting.name ==  SyllabusScreen.name ){
      screenWidgets = const SyllabusScreen();
    }else if(setting.name ==  HomeScreen.name ){
      screenWidgets = const HomeScreen();
    }
    return MaterialPageRoute(builder: (context) => screenWidgets);
  }
}