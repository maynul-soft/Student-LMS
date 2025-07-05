import 'package:flutter/material.dart';
import 'package:lms/app/firebase_messaging/fcm.dart';
import 'package:lms/app/utils/app_colors.dart';
import 'package:lms/app/utils/assets_path.dart';
import 'package:lms/features/auth/ui/screens/login_screen.dart';
import 'package:lms/features/home/ui/screens/home_screen.dart';

import '../../../../common/controller/auth_controller.dart' show AuthController;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    _navigateToHome();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _navigateToHome() async {
    await AuthController.getUserInformation();
    bool isUserLoggedIn = await AuthController.checkIsUseLoggedIn();

    await Future.delayed(const Duration(seconds: 3), () {});

    isUserLoggedIn
        ? Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.name, (predicate) => false)
        : Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.name, (predicate) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsPaths.appLogoPng,
            height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            FadeTransition(
              opacity: _animation,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.black, // Background color of the container
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
                child: const Text(
                  'Conducted By Parvez Sir',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF9BD770), // Text color
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
