import 'package:flutter/material.dart';
import 'package:gas_station/screens/login.dart';
import 'package:gas_station/screens/reset_password.dart';
import 'package:gas_station/screens/verify_code.dart';
import 'package:gas_station/utils/constants.dart';
import 'package:gas_station/widgets/custom_back_button.dart';
import 'package:gas_station/widgets/custom_primary_button.dart';
import 'package:gas_station/widgets/custom_text_feild.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              CustomBackButton(),
              const SizedBox(height: 10),
              const Text("Forgot password?", style: primaryTextStyle),

              Center(
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Image(
                    image: AssetImage('assets/images/forget_pass.png'),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                "Don’t worry! It happens. Please enter the email associated with your account.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              CustomTextFeild(controller: emailController),

              const SizedBox(height: 20),
              CustomPrimaryButton(
                label: 'Send Code',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          VerifyCodeScreen(email: emailController.text),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Remember password?   ",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Log in   ",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Text(' - or -', style: TextStyle(fontSize: 10)),

                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPassword(),
                          ),
                        ),
                        child: Text(
                          'Reset password',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
