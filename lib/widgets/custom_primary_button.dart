import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;

  const CustomPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6DB944),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label, style: TextStyle(fontSize: 14, color: Colors.white)),
      ),
    );
  }
}
