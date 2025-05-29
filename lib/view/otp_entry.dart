import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_app/view/reset_email_entry.dart';
import 'package:todo_app/view_model/auth_bloc/auth_bloc.dart';
import 'package:todo_app/view_model/auth_bloc/auth_event.dart';
import 'package:todo_app/view_model/auth_bloc/auth_states.dart';

class VerificationPage extends StatefulWidget {
  final String email;
  const VerificationPage({super.key, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late String otp;
  int timer = 60;
  @override
  void initState() {
    super.initState();
    tick();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          padding: EdgeInsets.all(0),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bwfishes.jpg"),
                  fit: BoxFit.cover)),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 35),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
                        ],
                        radius: 0.8,
                      ),
                    ),
                    child: const Center(
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 77, 32, 14),
                          maxRadius: 35,
                          child: Icon(
                            Icons
                                .mark_email_unread, // Use email icon for verification page
                            size: 26,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Verification Code',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comic Sans MS',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("We have sent the verification code to",
                      style: TextStyle(
                        fontSize: 11,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Comic Sans MS',
                      )),
                    Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 184, 13, 13),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  OtpTextField(
                    onSubmit: (value) => {otp=value},
                    cursorColor: Colors.black,
                      fieldWidth: 35,
                      fieldHeight: 50,
                      autoFocus: true,
                      numberOfFields: 6,
                      showFieldAsBox: true,
                      focusedBorderColor: Colors.brown,
                      borderColor: const Color(0xFF512DA8)),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: timer > 0
                        ? null
                        : () {
                            setState(() {
                              timer = 60;
                            });
                            tick();
                            BlocProvider.of<AuthBloc>(context).add(
                                      AuthResetPasswordEvent(
                                          email: widget.email));
                          },
                    child: timer > 0
                        ? Text("Resend the code in $timer s",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold,
                            ))
                        : const Text(
                            "Resend Code",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 13,
                              fontFamily: 'Comic Sans MS',
                            ),
                          ),
                  ),
                ],
              ),
            ),
            BlocConsumer<AuthBloc,AuthState>(
              listener:(context,state){
                if(state is AuthResetEmailUnverified){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                }
                else if(state is AuthResetEmailVerified){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailEntry()));
                }
              } ,
              builder: (context,state){
                 return Positioned(
                  bottom: 50,
                  left: 10,
                  right: 10,
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                        onPressed:state is AuthResetLoading?null: () {
                          BlocProvider.of<AuthBloc>(context).add(AuthPinVerifyEvent(otp: otp, email: widget.email));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 107, 53, 49),
                          foregroundColor: Colors.white, // Text color
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // Rounded corners
                          ),
                        ),
                        child:state is AuthResetLoading? const SpinKitThreeInOut(color: Colors.white,): const Text(
                          "Verify",
                          style: TextStyle(
                              fontFamily: 'Comic Sans MS',
                              fontWeight: FontWeight.bold),
                        )),
                  ));
                
              },
              

            )
          ]),
        ),
      ),
    );
  }

  void tick() {
    Future.delayed(const Duration(seconds: 1), () {
      if (timer > 0) {
        setState(() {
          timer--;
        });
        tick();
      }
    });
  }
}
