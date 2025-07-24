import 'package:flutter/material.dart';
import 'package:lms/app/constants/app_text.dart';
import 'package:lms/features/auth/data/services/login_service.dart';
import '../../../../common/widgets/input_field.dart';

class LoginFrom extends StatefulWidget {
  const LoginFrom({super.key});

  @override
  State<LoginFrom> createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  final TextEditingController _idTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome to ${AppTexts.legendsChemistryInitialCapital}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              ReusableInputField(
                labelText: 'Student ID',
                controller: _idTEController,
                icon: Icons.person,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter you user id';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ReusableInputField(
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter you user id';
                  }
                  return null;
                },
                labelText: 'Password',
                isPassword: true,
                controller: _passwordTEController,
                icon: Icons.lock,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _onTapLogin,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Visibility(
                  visible: isLoading == false,
                  replacement: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  child: const Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.login_outlined),
                      Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onTapLogin() async {
    isLoading = true;
    setState(() {});

    if (_formKey.currentState!.validate()) {
      await loginService(
          id: _idTEController.text, password: _passwordTEController.text);
    }


    isLoading = false;
    setState(() {});
  }
}
//parvezsir.net/api/student/3747/8801712293628