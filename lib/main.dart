import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/home.dart';
import 'package:todo_app/view/login.dart';
import 'package:todo_app/view/otp_entry.dart';
import 'package:todo_app/view/recovery_password_entry.dart';
import 'package:todo_app/view/reset_email_entry.dart';
import 'package:todo_app/view/sign_up.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'firebase_options.dart';
void main() async {
  await Hive.initFlutter();
  await Hive.openBox("myBox");
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform, );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:   RecoveryPasswordEntry(),
      theme: ThemeData(
        primarySwatch: Colors.yellow, // Set the primary swatch color
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
