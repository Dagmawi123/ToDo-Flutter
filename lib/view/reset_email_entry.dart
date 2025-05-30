import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_app/view/otp_entry.dart';
import 'package:todo_app/view_model/auth_bloc/auth_bloc.dart';
import 'package:todo_app/view_model/auth_bloc/auth_event.dart';
import 'package:todo_app/view_model/auth_bloc/auth_states.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';

class EmailEntry extends StatefulWidget {
  const EmailEntry({super.key});

  @override
  State<EmailEntry> createState() => _EmailEntryState();
}

class _EmailEntryState extends State<EmailEntry> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/mount.jpg"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox.expand(
            child: Stack(
              children: [
                const Positioned(
                    top: 120,
                    left: 10,
                    right: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reset Password",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Comic Sans MS',
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Please enter your email below to receive your short code",
                          maxLines: null,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 75, 75, 75)),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Positioned(
                  top: 240,
                  left: 10,
                  right: 10,
                  child: Container(
                      height: 70,
                      width: 300,
                      child: Form(
                        key: _globalKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          controller: _emailController,
                          style: const TextStyle(backgroundColor: Colors.white),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: const Icon(Icons.email),
                              hintText: 'dagm@gmail.com',
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 156, 156, 156)),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              )),
                          validator: (email) {
                            if (email == "") {
                              return "Email should not be empty";
                            }
                            if (email != null) {
                              if (!isValidEmail(email)) {
                                return "Email should contain @ and .";
                              }
                            }
                            return null;
                          },
                        ),
                      )),
                ),
                Positioned(
                    top: 310,
                    left: 10,
                    right: 10,
                    child: SizedBox(
                      height: 40,
                      child: BlocConsumer<AuthBloc,AuthState>(
                        listener: (context, state) {
                          if(state is AuthResetEmailSent){
                            Navigator.pop(context); 
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>VerificationPage(email: _emailController.text,)));
                          }
                          else if(state is AuthResetFailure){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthResetLoading) {
                            return ElevatedButton(
                                onPressed: null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 57, 58, 59),
                                  foregroundColor: Colors.white, // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Rounded corners
                                  ),
                                ),
                                child: const SpinKitThreeInOut(
                                  color: Colors.white,
                                  size: 20.0,
                                ));
                          } else {
                            return ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<AuthBloc>(context).add(
                                      AuthResetPasswordEvent(
                                          email: _emailController.text));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 57, 58, 59),
                                  foregroundColor: Colors.white, // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Rounded corners
                                  ),
                                ),
                                child: const Text(
                                  "Send OTP",
                                  style: TextStyle(
                                      fontFamily: 'Comic Sans MS',
                                      fontWeight: FontWeight.bold),
                                ));
                          }
                        },
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
