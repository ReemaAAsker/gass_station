import 'package:flutter/material.dart';
import 'package:gas_station/screens/login.dart';
import 'package:gas_station/utils/constants.dart';
import 'package:gas_station/widgets/custom_back_button.dart';
import 'package:gas_station/widgets/custom_primary_button.dart';

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(alignment: Alignment.topLeft, child: CustomBackButton()),

              SizedBox(height: 30),

              Image(image: AssetImage('assets/signup.png')),
              Text("Password changed", style: scoundryTextStyle),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Your password has been changed succesfully",
                  style: TextStyle(fontSize: 11),
                ),
              ),
              SizedBox(height: 70),
              CustomPrimaryButton(
                label: 'Back to login',
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
