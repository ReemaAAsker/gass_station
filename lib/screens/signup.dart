import 'package:flutter/material.dart';
import 'package:gas_station/screens/login.dart';
import 'package:gas_station/services/auth/firebase_services.dart';
import 'package:gas_station/utils/constants.dart';
import 'package:gas_station/widgets/custom_back_button.dart';
import 'package:gas_station/widgets/custom_notification.dart';
import 'package:gas_station/widgets/custom_primary_button.dart';
import 'package:gas_station/widgets/custom_text_feild.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool accept = false;
  bool isLoading = false;

  // Text controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FirebaseService _authService = FirebaseService();

  /// ✅ Handle user registration
  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      showSnackBar(context, "Passwords do not match", Colors.red);
      return;
    }

    if (!accept) {
      showSnackBar(
        context,
        "Please accept the terms and conditions",
        Colors.red,
      );
      return;
    }

    setState(() => isLoading = true);

    final success = await _authService.registerUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _usernameController.text.trim(),
    );

    setState(() => isLoading = false);

    if (success) {
      showSnackBar(context, "Registration successful!", Colors.green);
      Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        ),
      );
    } else {
      showSnackBar(context, "Registration failed. Try again.", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackButton(),
                Center(
                  child: SizedBox(
                    height: 100,
                    child: Image.asset('assets/images/signup.png'),
                  ),
                ),
                const Center(
                  child: Text(
                    "Create Account",
                    textAlign: TextAlign.center,
                    style: primaryTextStyle,
                  ),
                ),
                const SizedBox(height: 30),

                const Text(
                  'Username',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomTextFeild(
                  controller: _usernameController,
                  hintText: 'your username',
                  validation: (value) => value == null || value.isEmpty
                      ? 'Please enter your username'
                      : null,
                ),

                const SizedBox(height: 20),
                const Text(
                  'Email address',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomTextFeild(
                  controller: _emailController,
                  hintText: 'your email',
                  validation: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter your email';
                    if (!value.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                const Text(
                  'Password',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomTextFeild(
                  controller: _passwordController,
                  hintText: 'password',
                  isPassword: true,
                  validation: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter your password';
                    if (value.length < 5)
                      return 'Password should be at least 5 characters';
                    if (!value.contains(RegExp(r'[0-9]')))
                      return 'Include at least one number';
                    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')))
                      return 'Include a special character';
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                const Text(
                  'Confirm Password',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomTextFeild(
                  controller: _confirmPasswordController,
                  hintText: 'repeat password',
                  isPassword: true,
                  validation: (value) => value == null || value.isEmpty
                      ? 'Please confirm your password'
                      : null,
                ),

                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      shape: const CircleBorder(),
                      value: accept,
                      activeColor: const Color(0xFF6DB944),
                      onChanged: (value) =>
                          setState(() => accept = value ?? false),
                    ),
                    const Text(
                      "I accept the terms and privacy policy",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                CustomPrimaryButton(
                  label: isLoading ? 'Registering...' : 'Sign Up',
                  onPressed: isLoading ? null : _handleSignUp,
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
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
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
