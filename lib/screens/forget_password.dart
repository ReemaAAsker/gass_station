import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas_station/screens/login.dart';
import 'package:gas_station/screens/reset_password.dart';
import 'package:gas_station/screens/verify_code.dart';
import 'package:gas_station/services/auth/firebase_services.dart';
import 'package:gas_station/utils/constants.dart';
import 'package:gas_station/widgets/custom_back_button.dart';
import 'package:gas_station/widgets/custom_notification.dart';
import 'package:gas_station/widgets/custom_primary_button.dart';
import 'package:gas_station/widgets/custom_text_feild.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  void _sendCode() async {
    if (_formKey.currentState!.validate()) {
      FirebaseService().isEmailExist(emailController.text.trim()).then((value) {
        if (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  VerifyCodeScreen(email: emailController.text.trim()),
            ),
          );
        } else {
          showSnackBar(context, "The email is not registered before");
        }
      });
    }
  }

  @override
  void dispose() {
    emailController.text = "";
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔙 Back button
                const CustomBackButton(),
                const SizedBox(height: 10),

                const Text("Forgot password?", style: primaryTextStyle),

                Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.asset('assets/images/forget_pass.png'),
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  "Don’t worry! It happens. Please enter the email associated with your account.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                CustomTextFeild(
                  controller: emailController,
                  hintText: 'Enter your email',
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                      r'^[^@]+@[^@]+\.[^@]+',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                CustomPrimaryButton(label: 'Send Code', onPressed: _sendCode),

                const SizedBox(height: 10),

                // 🔁 Footer links
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Remember password?   ",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      ),
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text('-', style: TextStyle(fontSize: 10)),
                    const SizedBox(width: 5),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
