import 'package:flutter/material.dart';
import 'package:gas_station/screens/login.dart';
import 'package:gas_station/screens/welcom_screen.dart';
import 'package:gas_station/widgets/payment.dart';

void main(List<String> args) {
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
      home: const CardDetailsScreen(),
    );
  }
}
