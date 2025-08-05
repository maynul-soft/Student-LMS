import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lms/app/controller_binder.dart';
import 'package:lms/app/utils/app_theme.dart';
import 'package:lms/app/utils/app_routes.dart';

import '../features/auth/ui/screens/splash_screen.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Parvej Sir',
      theme: AppTheme.lightThemeData,
      home: const SplashScreen(),
      initialRoute: SplashScreen.name,
      onGenerateRoute: AppRoutes.routes,
      initialBinding: ControllerBinder(),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();