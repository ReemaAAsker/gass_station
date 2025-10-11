import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gas_station/screens/forget_password.dart';
import 'package:gas_station/screens/signup.dart';
import 'package:gas_station/screens/welcom_screen.dart';
import 'package:gas_station/services/auth/firebase_services.dart';
import 'package:gas_station/widgets/custom_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gas_station/widgets/custom_primary_button.dart';
import 'package:gas_station/widgets/custom_text_feild.dart';
import 'package:gas_station/utils/constants.dart';
import 'package:gas_station/widgets/custom_back_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool rememberMe = false;
  bool isLoading = false;

  final FirebaseService _authService = FirebaseService();

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
  }

  /// ✅ Check SharedPreferences for saved login
  Future<void> _checkAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final savedRemember = prefs.getBool('rememberMe') ?? false;

    if (!savedRemember) return;

    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    if (savedEmail != null && savedPassword != null) {
      final success = await _authService.loginUser(
        email: savedEmail,
        password: savedPassword,
      );

      if (success && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        );
      }
    }
  }

  /// ✅ Save login credentials
  Future<void> _saveLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setString('email', _emailController.text.trim());
      await prefs.setString('password', _passwordController.text.trim());
      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.clear();
    }
  }

  /// ✅ Login logic
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final success = await _authService.loginUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (success) {
      await _saveLoginInfo();
      if (!mounted) return;

      showSnackBar(context, "Login successful!", Colors.green);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    } else {
      showSnackBar(
        context,
        "Login failed. Please check your credentials.",
        Colors.red,
      );
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
                const SizedBox(height: 20),

                Text(
                  "Welcome back to Gas\nStation App!👋",
                  style: scoundryTextStyle,
                ),
                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    "You can now Login\nto your account",
                    textAlign: TextAlign.center,
                    style: primaryTextStyle,
                  ),
                ),
                const SizedBox(height: 30),

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
                    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegExp.hasMatch(value))
                      return 'Please enter a valid email';
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
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          shape: const CircleBorder(),
                          value: rememberMe,
                          activeColor: const Color(0xFF6DB944),
                          onChanged: (value) {
                            setState(() => rememberMe = value ?? false);
                          },
                        ),
                        const Text(
                          "Remember me",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ForgotPasswordScreen(),
                        ),
                      ),
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),

                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomPrimaryButton(label: 'Log in', onPressed: _login),
                const SizedBox(height: 20),

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
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      ),
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
      ),
    );
  }
}
