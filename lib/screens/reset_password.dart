import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder_app/widgets/responsive_container.dart';
import '../model/pages_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  late String email;
  bool showSpinner = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 30, top: 167),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Forgot Pasword',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 7, 107, 132),
                    ),
                  ),
                ),
              ),
              ResponsiveContainer(
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 60, right: 60),
                  child: Text(
                    'Enter Your Email Address',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                  height: 50,
                  width: 250,
                  child: TextField(
                    //put controller here to viledate if the email field is empty or not
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'user@gmail.com',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: const Color.fromARGB(255, 7, 107, 132),
                            width: 2,
                          )),
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                ),
              ),
              ResponsiveContainer(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: RichText(
                    text: TextSpan(
                        text: 'Back to login',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(125, 0, 0, 0),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, logInPage);
                          }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
                child: SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: const Color.fromARGB(255, 7, 107, 132),
                    ),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      String email = _emailController.text.trim();
                      if (email.isEmpty) {
                        setState(() {
                          showSpinner = false;
                        });
                        Flushbar(
                          message: "Email cannot be empty",
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 3),
                          flushbarPosition: FlushbarPosition.BOTTOM,
                        ).show(context);
                      } else {
                        try {
                          await _auth.sendPasswordResetEmail(email: email);
                          // ignore: use_build_context_synchronously
                          // Navigator.pushNamed(context, verificationPage);
                          Flushbar(
                            message:
                                'Reset link send it to your emaill address successfully back to login page',
                            backgroundColor: Colors.green,
                            duration: const Duration(minutes: 1),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            mainButton: TextButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  side: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, logInPage);
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ).show(context);
                          setState(() {
                            showSpinner = false;
                          });
                        } on FirebaseAuthException catch (e) {
                          String message;
                          if (e.code == 'invalid-email') {
                            message = 'This email is invalid';
                          } else if (e.code == 'user-not-found') {
                            message =
                                'User not found. Please enter a valid email address';
                          } else {
                            message = 'An error occurred';
                          }
                          setState(() {
                            showSpinner = false;
                          });
                          Flushbar(
                            message: message,
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 3),
                            flushbarPosition: FlushbarPosition.BOTTOM,
                          ).show(context);
                        }
                      }
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                    child: Text(
                  'Do you have an account?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(125, 0, 0, 0),
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 16, right: 16, bottom: 0),
                child: SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                          color: const Color.fromARGB(255, 7, 107, 132),
                          width: 2),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, signUpPage);
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: 18, color: Color.fromARGB(125, 0, 0, 0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
