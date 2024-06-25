import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms/Reuseable/input_field.dart';
import 'package:lms/Screens/Dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}
//8801714012797
class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login(BuildContext context) async {
    final String apiUrl =
        "https://bidhansirbd.com/api/student/${emailController.text}/${passwordController.text}";

    setState(() {
      _isLoading = true;
    });

    try {
      // Perform login request
      final response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> loginData = jsonDecode(response.body);

        setState(() {
          _isLoading = false;
        });

        // Handle successful login and user info retrieval here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful: ${loginData['student_name']}')),
        );

        // Navigate to the DashboardPage after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      } else {
        setState(() {
          _isLoading = false;
        });

        final Map<String, dynamic> responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${responseData['message']}')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

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
                                  Text('Please add student ID and password')),
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
