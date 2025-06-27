import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms/features/home/ui/screens/home_screen.dart';
import 'package:lms/cmmon/widgets/input_field.dart';

class LoginFrom extends StatefulWidget {
  const LoginFrom({Key? key}) : super(key: key);

  @override
  State<LoginFrom> createState() => _LoginFromState();
}

//3747 8801712293628
// https://static.vecteezy.com/system/resources/thumbnails/004/899/680/small/beautiful-blonde-woman-with-makeup-avatar-for-a-beauty-salon-illustration-in-the-cartoon-style-vector.jpg
class _LoginFromState extends State<LoginFrom> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login(BuildContext context) async {
    final String apiUrl =
        "https://parvezsir.net/api/student/${emailController.text}/${passwordController.text}";

    setState(() {
      _isLoading = true;
    });

    try {
      print('Making API request to $apiUrl'); // Debug log

      // Perform login request using http package
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      print('Response status: ${response.statusCode}'); // Debug log
      final responseBody = response.body;
      print('Response body: $responseBody'); // Debug log

      if (response.statusCode == 200) {
        final Map<String, dynamic> loginData = jsonDecode(responseBody);

        setState(() {
          _isLoading = false;
        });

        // Handle successful login and user info retrieval here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Login successful: ${loginData['data']['student_name']}')),
        );

        // Navigate to the DashboardPage after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    userData: loginData['data'],
                  )),
        );
      } else {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Login failed: Email and password do not match')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      print('Login error: $e'); // Debug log

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Login failed: Email and password do not match')),
      );
    }
  }

  // Example credentials: 3000, 8801714012797
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Student Login Form',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ReusableInputField(
              labelText: 'Student ID',
              controller: emailController,
              icon: Icons.person,
            ),
            const SizedBox(height: 16.0),
            ReusableInputField(
              labelText: 'Password',
              isPassword: true,
              controller: passwordController,
              icon: Icons.lock,
            ),
            const SizedBox(height: 16.0),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton.icon(
                    onPressed: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Please enter student ID and password')),
                        );
                      } else {
                        _login(context);
                      }
                    },
                    icon: const Icon(
                      Icons.login,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Login',
                      style:
                          TextStyle(color: Color.fromARGB(255, 221, 221, 221)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
