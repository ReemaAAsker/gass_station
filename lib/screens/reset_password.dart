import 'package:flutter/material.dart';
import 'package:gas_station/screens/login.dart';
import 'package:gas_station/screens/password_changed.dart';
import 'package:gas_station/utils/constants.dart';
import 'package:gas_station/widgets/custom_back_button.dart';
import 'package:gas_station/widgets/custom_primary_button.dart';
import 'package:gas_station/widgets/custom_text_feild.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPssword = TextEditingController();

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
              SizedBox(height: 20),
              const Text("Reset Password", style: primaryTextStyle),
              const Text("Please type something you’ll remember"),

              Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image(
                    image: AssetImage('assets/images/reset_password.png'),
                  ),
                ),
              ),

              const Text("New Password"),
              const SizedBox(height: 10),

              CustomTextFeild(
                controller: newPassword,
                hintText: 'must be 8 characters',
              ),
              const SizedBox(height: 20),
              const Text("Confirm new Password"),
              const SizedBox(height: 10),
              CustomTextFeild(
                controller: confirmNewPssword,
                hintText: 'must be 8 characters',
              ),

              const SizedBox(height: 20),
              CustomPrimaryButton(
                label: 'ResetPassword',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PasswordChanged()),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
