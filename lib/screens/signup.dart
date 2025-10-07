import 'package:flutter/material.dart';
import 'package:gas_station/screens/login.dart';
import 'package:gas_station/utils/constants.dart';
import 'package:gas_station/widgets/custom_back_button.dart';
import 'package:gas_station/widgets/custom_primary_button.dart';
import 'package:gas_station/widgets/custom_text_feild.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

              Center(
                child: SizedBox(
                  height: 100,

                  child: Image(image: AssetImage('assets/images/signup.png')),
                ),
              ),

              // Heading
              Center(
                child: const Text(
                  textAlign: TextAlign.center,
                  "Create Account",
                  style: primaryTextStyle,
                ),
              ),
              const SizedBox(height: 30),
              Text('Username', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              // Email field
              CustomTextFeild(
                hintText: 'your username',
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              Text(
                'Confirm Password',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              CustomTextFeild(
                hintText: 'repeat password',
                isPassword: true,
                validation: (value) {},
              ),
              SizedBox(height: 20),
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
                  const Text(
                    "I accept the terms and privacy policy",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Login button
              CustomPrimaryButton(label: 'Sign Up', onPressed: () => {}),
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
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                        color: secoundaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
