import 'package:flutter/material.dart';
import 'package:gas_station/screens/forget_password.dart';
import 'package:gas_station/screens/signup.dart';
import 'package:gas_station/utils/constants.dart';
import 'package:gas_station/widgets/custom_back_button.dart';
import 'package:gas_station/widgets/custom_primary_button.dart';
import 'package:gas_station/widgets/custom_text_feild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              CustomBackButton(),
              const SizedBox(height: 20),

              // Welcome text
              Text(
                "Welcome back to Gas\n Station App!👋 ",
                style: scoundryTextStyle,
              ),

              const SizedBox(height: 20),

              // Heading
              Center(
                child: const Text(
                  textAlign: TextAlign.center,
                  "You can now Login\nto your account",
                  style: primaryTextStyle,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Email address',

                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Email field
              CustomTextFeild(
                hintText: 'your email',
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text('Password', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              // Password field
              CustomTextFeild(
                hintText: 'password',
                isPassword: true,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  //password should have at least 5 characters and the characters should has number and speical charcter

                  if (value.length < 5 ||
                      !value.contains(RegExp(r'[0-9]')) ||
                      !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                    return 'Password should have at least 5 characters and the characters should has number and speical charcter';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Remember me + Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        shape: CircleBorder(),
                        value: rememberMe,
                        activeColor: const Color(0xFF6DB944),
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                          });
                        },
                      ),
                      const Text("Remember me", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    ),
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100),

              // Login button
              CustomPrimaryButton(label: 'Log in', onPressed: () => {}),
              const SizedBox(height: 20),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don’t have an account? ",
                    style: TextStyle(fontSize: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: secoundaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
