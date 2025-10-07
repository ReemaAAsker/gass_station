import 'package:flutter/material.dart';

class CustomBackButton extends StatefulWidget {
  const CustomBackButton({super.key});

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 40,
        width: 40,
        child: OutlinedButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),

          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.only(right: 0),
            // padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),

            side: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
