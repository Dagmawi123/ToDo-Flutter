import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/home.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/view/login.dart';
import 'package:todo_app/view/sign_up.dart';
void main() async {  
  await Hive.initFlutter();
 await Hive.openBox("myBox");
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPage(),
      theme: ThemeData(
        primarySwatch: Colors.yellow, // Set the primary swatch color
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
