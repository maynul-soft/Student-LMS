import 'package:flutter/material.dart';
import 'package:lms/Screens/LoginPage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: const Color(0xFF9BD770),
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Legends Physics',
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
                    'Conducted By Jahangir Sir',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9BD770), // Text color
                    ),
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true, // Center the title in the AppBar
        ),
      ),
      body: const LoginPage(),
    );
  }
}
