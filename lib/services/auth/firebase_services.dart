import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔹 Register user and save data in Firestore
  Future<bool> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCred.user!.uid).set({
        'email': email,
        'name': name,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint("Register Error: ${e.code}");
      return false;
    } catch (e) {
      debugPrint("Register Error: $e");
      return false;
    }
  }

  /// 🔹 Login
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint("Login Error: ${e.code}");
      return false;
    } catch (e) {
      debugPrint("Login Error: $e");
      return false;
    }
  }

  /// 🔹 Password reset
  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      debugPrint("Reset password error: $e");
      return false;
    }
  }

  /// 🔹 Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// 🔹 Get current user
  User? get currentUser => _auth.currentUser;

  /// Generate random 4-digit OTP
  String generateOtp() => (1000 + Random().nextInt(8999)).toString();

  /// Send OTP to Firestore
  Future<bool> sendOtp(String email) async {
    final otp = generateOtp();
    try {
      await _firestore.collection('emailOtps').doc(email).set({
        'otp': otp,
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (kDebugMode) debugPrint("📩 OTP for $email is $otp");
      return true;
    } catch (e) {
      debugPrint("Error saving OTP: $e");
      return false;
    }
  }

  /// Verify entered OTP against Firestore
  Future<bool> verifyOtp(String email, String enteredOtp) async {
    try {
      final snapshot = await _firestore
          .collection('emailOtps')
          .doc(email)
          .get();

      if (!snapshot.exists) return false;
      final storedOtp = snapshot.data()?['otp'];

      return storedOtp == enteredOtp;
    } catch (e) {
      debugPrint("Error verifying OTP: $e");
      return false;
    }
  }

  Future<bool> isEmailExist(String userEmail) async {
    try {
      final query = await _firestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();

      return query.docs.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking email existence: $e');
      return false;
    }
  }
}
