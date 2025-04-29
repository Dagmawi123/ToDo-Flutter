import 'package:flutter/material.dart';

class RecoveryPasswordEntry extends StatefulWidget {
  const RecoveryPasswordEntry({super.key});

  @override
  State<RecoveryPasswordEntry> createState() => _RecoveryPasswordEntryState();
}

class _RecoveryPasswordEntryState extends State<RecoveryPasswordEntry> {
  bool _passVisible = false;
  bool _passVisible2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/jellyfish.jpg")
              ,fit: BoxFit.cover),
            ),
            child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: const TextSpan(
                      style: TextStyle(fontFamily: "Comic Sans MS"),
                      children: [
                        TextSpan(
                            text: "New Password\n",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 255, 245, 245))),
                        TextSpan(
                            text: "Enter your new password",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 192, 162, 162)))
                      ]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: !_passVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () => {
                      setState(() {
                        _passVisible = !_passVisible;
                      })
                    },
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(
                    color: Colors.grey
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: !_passVisible2,
                decoration: InputDecoration(
                   filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                    color: Colors.grey
                  ),
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () => {
                      setState(() {
                        _passVisible2 = !_passVisible2;
                      })
                    },
                  ),
                  hintText: "Confirm password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
               SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 107, 53, 49).withOpacity(0.75), 
                      foregroundColor: Colors.white.withOpacity(0.94), // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Rounded corners
                      ),
                    ),
                    child: const Text(
                      "Reset Password",
                      style: TextStyle(
                          fontFamily: 'Comic Sans MS', fontWeight: FontWeight.bold),
                    )),
              ),
            ],
                    ),
                  ),
          )),
    );
  }
}
