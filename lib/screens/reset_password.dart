import 'package:gas_station/widgets/custom_text_feild.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gas_station/screens/password_changed.dart';
import 'package:gas_station/utils/constants.dart';
import 'package:gas_station/widgets/custom_back_button.dart';
import 'package:gas_station/widgets/custom_primary_button.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      if (newPassword.text != confirmNewPassword.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match!")),
        );
        return;
      }

      setState(() => isLoading = true);

      try {
        final user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          await user.updatePassword(newPassword.text.trim());

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password updated successfully!")),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const PasswordChanged()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User not authenticated.")),
          );
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Error updating password")),
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    newPassword.dispose();
    confirmNewPassword.dispose();
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
                const CustomBackButton(),
                const SizedBox(height: 20),
                const Text("Reset Password", style: primaryTextStyle),
                const Text("Please type something you’ll remember"),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset('assets/images/reset_password.png'),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("New Password"),
                const SizedBox(height: 10),
                CustomTextFeild(
                  controller: newPassword,
                  hintText: 'New password',
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
                const Text("Confirm new Password"),
                const SizedBox(height: 10),
                CustomTextFeild(
                  controller: confirmNewPassword,
                  hintText: 'confirm password',
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
                CustomPrimaryButton(
                  label: isLoading ? "Processing..." : 'Reset Password',
                  onPressed: isLoading ? null : _resetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
