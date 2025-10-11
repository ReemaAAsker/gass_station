import 'dart:async';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:gas_station/screens/welcom_screen.dart';
import 'package:gas_station/widgets/custom_notification.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:gas_station/utils/constants.dart';
import 'package:gas_station/widgets/custom_back_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;

  const VerifyCodeScreen({super.key, required this.email});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  static const int resendDelay = 25;
  late Timer _timer;

  int secondsRemaining = resendDelay;
  bool isLoading = false;
  String otpCode = "";

  final TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _sendOtpToEmail();
    _startResendTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  Future<void> _sendOtpToEmail() async {
    try {
      await EmailOTP.sendOTP(email: widget.email);
      showSnackBar(context, "📩 Code sent to ${widget.email}", Colors.green);
    } catch (e) {
      showSnackBar(context, "❌ Failed to send OTP: $e", Colors.red);
    }
  }

  Future<void> _verifyOTP() async {
    if (isLoading || otpCode.length != 4) return;

    setState(() => isLoading = true);

    try {
      bool success = await EmailOTP.verifyOTP(otp: otpCode);

      if (!mounted) return;

      if (success) {
        showSnackBar(context, "✅ Code verified successfully!", Colors.green);
        await Future.delayed(const Duration(seconds: 1));

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          );
        }
      } else {
        showSnackBar(context, "❌ Invalid code. Try again.", Colors.red);
        _pinController.clear();
      }
    } catch (e) {
      showSnackBar(context, "❌ Verification error: $e", Colors.red);
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _resendCode() async {
    setState(() {
      secondsRemaining = resendDelay;
    });
    _startResendTimer();
    await _sendOtpToEmail();
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
              const CustomBackButton(),
              const SizedBox(height: 10),
              Text("Please check your email", style: scoundryTextStyle),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: "We have sent a verification code to ",
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: widget.email,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              /// 🔢 OTP Input
              PinCodeTextField(
                length: 4,
                appContext: context,
                controller: _pinController,
                onChanged: (value) async {
                  otpCode = value;

                  if (value.length == 4 && !isLoading) {
                    await _verifyOTP();
                  }
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

              /// ✅ Manual verify button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _verifyOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    isLoading ? "Verifying..." : "Verify",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// 🔁 Resend code
              Center(
                child: GestureDetector(
                  onTap: secondsRemaining == 0 ? _resendCode : null,
                  child: Text(
                    secondsRemaining > 0
                        ? "Send code again in 00:${secondsRemaining.toString().padLeft(2, '0')}"
                        : "Resend code",
                    style: TextStyle(
                      fontSize: 16,
                      color: secondsRemaining == 0 ? Colors.green : Colors.grey,
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
