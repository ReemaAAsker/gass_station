import 'package:flutter/material.dart';
import 'package:gas_station/utils/constants.dart';
import 'package:gas_station/widgets/custom_back_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;
  const VerifyCodeScreen({super.key, required this.email});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  String otpCode = "";
  int seconds = 20;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Future.doWhile(() async {
      if (seconds == 0) return false;
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        seconds--;
      });
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(),
              const SizedBox(height: 10),
              Text("Please check your email", style: scoundryTextStyle),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "We have sent a verification code to ",

                  children: [
                    TextSpan(
                      text: widget.email,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              PinCodeTextField(
                length: 4,
                appContext: context,
                onChanged: (value) {
                  setState(() {
                    otpCode = value;
                  });
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 60,
                  fieldWidth: 60,
                  activeFillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: otpCode.length == 4
                      ? () {
                          // تحقق من الكود هنا
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Code Verified!")),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Verify",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  seconds > 0
                      ? "Send code again in 00:${seconds.toString().padLeft(2, '0')}"
                      : "Resend code",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
