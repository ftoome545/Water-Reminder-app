import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
  late String email;
  bool showSpinner = false;
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
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 80, right: 80),
                child: Text(
                  'Enter Your Email Address',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                  height: 80,
                  width: 250,
                  child: TextField(
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
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 150),
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
                      try {
                        await _auth.sendPasswordResetEmail(email: email);
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, verificationPage);
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
                        )..show(context);
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
            ],
          ),
        ),
      ),
    );
  }
}
