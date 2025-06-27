import 'package:flutter/material.dart';
import 'package:lms/app/app_theme.dart';

import '../features/auth/ui/screens/splash_screen.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JM Sir',
      theme: AppTheme.lightThemeData,
      home: const SplashScreen(),
    );
  }
}