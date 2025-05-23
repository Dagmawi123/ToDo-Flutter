import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemote {
  final Dio dio;
  AuthRemote({required this.dio});
  final String _baseURL = "https://otp-mailer-xi.vercel.app/";

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<UserCredential> login(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signOut();
      UserCredential userCred = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      ;
      return userCred;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<User> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await _firebaseAuth.signOut();
      UserCredential userCred = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _firebaseFirestore
          .collection("users")
          .doc(email)
          .set({"email": email, "registered": true});

      await userCred.user?.updateProfile(displayName: name);
      await userCred.user?.reload();
      return _firebaseAuth.currentUser!;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> sendResetEmail({required String email}) async {
    try {
      var isEmailRegistered = await _checkEmailExists(email);
      if (isEmailRegistered) {
        await dio.post("${_baseURL}send-otp", data: {"email": email});
      } else {
        throw Exception('Email not registered');
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception('Failed to reset password: $e');
      } else {
        throw Exception(e);
      }
    }
  }

  Future<bool> _checkEmailExists(String email) async {
    var doc = await _firebaseFirestore.collection("users").doc(email).get();
    return doc.exists; // If the document exists, email is registered!
  }

  Future<void> verifyPin({required String email, required int pin}) async {
    try {
      await dio.post("${_baseURL}verify-otp",
          data: {"email": email, "enteredOtp": pin});
    } catch (e) {
      if (e is DioException) {
        throw Exception('Incorrect OTP entered: $e');
      } else {
        throw Exception(e);
      }
    }
  }
}
