import 'package:flutter/material.dart';
import 'package:gas_station/screens/admin_page.dart';
import 'package:gas_station/screens/delivery_page.dart';
import 'package:gas_station/screens/login.dart';
import 'package:gas_station/screens/reset_password.dart';
import 'package:gas_station/screens/user_page.dart';
import 'package:gas_station/services/shred_pref_services.dart';
import 'package:gas_station/utils/constants.dart';
import 'package:gas_station/widgets/custom_back_button.dart';
import 'package:gas_station/widgets/custom_primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(),
                  IconButton(
                    icon: Icon(Icons.logout, size: 30, color: Colors.red),
                    onPressed: () async {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (value) => false,
                      );
                      await SharedPrefService.logout();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: const Text("Gass Station", style: primaryTextStyle),
              ),
              Text(
                "To know the fuel locations and fuel delivery",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image(image: AssetImage('assets/images/signup.png')),
                ),
              ),

              const Text(
                "Choose Role To Enter The App.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 30),
              CustomPrimaryButton(
                label: 'USER',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage()),
                ),
              ),
              SizedBox(height: 20),

              CustomPrimaryButton(
                label: 'ADMIN',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPage()),
                ),
              ),
              SizedBox(height: 20),
              CustomPrimaryButton(
                label: 'DELIVERY DRIVER',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeliveryPage()),
                ),
              ),

              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ResetPassword()),
                    );
                  },
                  child: const Text(
                    'Reset password',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
