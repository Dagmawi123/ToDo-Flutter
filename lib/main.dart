import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/auth_remote.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/view/sign_up.dart';
import 'package:todo_app/view_model/auth_bloc/auth_bloc.dart';
import 'package:todo_app/view_model/repository/auth_repository.dart';
import 'firebase_options.dart';

void main() async {
  // await Hive.initFlutter();
  // await Hive.openBox("myBox");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => AuthRemote()),
            RepositoryProvider(
                create: (context) =>
                    AuthRepository(authRemote: context.read<AuthRemote>())),
          ],
          child: Builder(
              builder: (context) => MultiBlocProvider(providers: [
                    BlocProvider<AuthBloc>(
                      create: (context) => AuthBloc(
                          authRepository: context.read<AuthRepository>()),
                    ),
                  ], child: SignUpPage()))),
      theme: ThemeData(
        primarySwatch: Colors.yellow, // Set the primary swatch color
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
