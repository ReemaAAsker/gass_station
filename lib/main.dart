import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:gas_station/firebase_options.dart';
import 'package:gas_station/screens/login.dart';
import 'package:gas_station/screens/welcom_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gas_station/services/shred_pref_services.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefService.init();

  EmailOTP.config(
    appName: 'Gas Station',
    otpType: OTPType.numeric,
    expiry: 30000,
    emailTheme: EmailTheme.v6,
    otpLength: 4,
  );
  runApp(APP());
}

class APP extends StatelessWidget {
  APP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.green,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
          bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
