import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:water_reminder_app/screens/reset_password.dart';

import '../model/pages_names.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String v1;
  late String v2;
  late String v3;
  late String v4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 80, bottom: 20, left: 1, right: 40),
                child: ListTile(
                  leading: const Icon(
                    Icons.arrow_back,
                    color: const Color.fromARGB(255, 7, 107, 132),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPassword()));
                  },
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 7, 107, 132),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24, left: 80, right: 80),
                child: Text(
                  'Enter Verification Code',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: verificationCode((value) {
                      v1 = value;
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: verificationCode((value) {
                      v2 = value;
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: verificationCode((value) {
                      v3 = value;
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: verificationCode((value) {
                      v4 = value;
                    }),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 70),
                child: RichText(
                  text: TextSpan(
                      text: 'If you didn’t receive a code,',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(125, 0, 0, 0),
                      ),
                      children: [
                        TextSpan(
                            text: ' Resend',
                            style: const TextStyle(
                              color: const Color.fromARGB(255, 7, 107, 132),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, resetPasswordPage);
                              }),
                      ]),
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
                      try {
                        setState(() {
                          showSpinner = true;
                        });
                        final String verification =
                            await _auth.verifyPasswordResetCode('$v1$v2$v3$v4');
                        Navigator.pushNamed(context, newPasswordPage);
                        setState(() {
                          showSpinner = false;
                        });
                      } on FirebaseAuthException catch (e) {
                        String message;
                        if (e.code == 'expired-action-code') {
                          message = 'The password reset code has expired';
                        } else if (e.code == 'invalid-action-code') {
                          message =
                              'The code is malformed or has already been used.';
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

  Widget verificationCode(Function(String) onChanged) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: const Color.fromARGB(255, 7, 107, 132),
                width: 2,
              )),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
