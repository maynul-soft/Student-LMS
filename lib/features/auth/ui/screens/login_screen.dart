import 'package:flutter/material.dart';
import 'package:lms/app/constants/app_text.dart';
import 'package:lms/app/utils/app_colors.dart';
import 'package:lms/features/auth/ui/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String name = 'login-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const LoginFrom(),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.themColor,
      title: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppTexts.legendsChemistryCapital,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 4.0),
              decoration: const BoxDecoration(
                color: Colors.black, // Background color of the container
                borderRadius: BorderRadius.all(
                    Radius.circular(12.0)), // Rounded corners
              ),
              child: const Text(
                AppTexts.conductedBy,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF9BD770), // Text color
                ),
              ),
            ),
           const SizedBox(height: 10,)
          ],
        ),
      ),
      centerTitle: true, // Center the title in the AppBar
    );
  }
}
