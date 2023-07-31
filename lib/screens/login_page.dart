import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../model/pages_names.dart';
import '../screens/reset_password.dart';
import '../widgets/email_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:another_flushbar/flushbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/login_image.jpg'),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 7, 107, 132),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: EmailPassword(
                  title: 'Email',
                  hint: 'Enter your email',
                  onchanged: (value) {
                    email = value;
                  },
                  obscureText: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: EmailPassword(
                  title: 'Password',
                  hint: 'Enter your password',
                  onchanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 180),
                // child: Text(
                //   'Forgot Password?',
                //   style: TextStyle(
                //       fontSize: 18, color: Color.fromARGB(255, 7, 96, 168)),
                // ),
                child: RichText(
                  text: TextSpan(
                      text: 'Forgot Passsword?',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 7, 107, 132),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ResetPassword()));
                        }),
                ),
              ),
              Stack(
                children: [
                  Image.asset(
                    'images/login_image_2.jpg',
                    width: 563.0,
                    height: 270.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 200.0,
                          left: 10,
                        ),
                        child: RichText(
                          text: TextSpan(
                              text: 'New here?',
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                              children: [
                                TextSpan(
                                    text: ' Sign Up',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, signUpPage);
                                      }),
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 130.0,
                          left: 33.0,
                        ),
                        child: SizedBox(
                          width: 130.8,
                          height: 57.14,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: const BorderSide(
                                    color: Colors.white, width: 2),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 7, 107, 132),
                            ),
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                // ignore: unnecessary_null_comparison
                                if (user != null) {
                                  Navigator.pushNamed(context, userDataPage);
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }
                              } on FirebaseAuthException catch (e) {
                                String message;
                                if (e.code == 'user-not-found') {
                                  message = 'User not found';
                                } else if (e.code == 'wrong-password') {
                                  message = 'Wrong password';
                                } else {
                                  message = 'An error occurred';
                                }
                                setState(() {
                                  showSpinner = false;
                                });
                                // Display the warning message using Flushbar
                                Flushbar(
                                  message: message,
                                  backgroundColor:
                                      const Color.fromARGB(222, 244, 67, 54),
                                  duration: const Duration(seconds: 3),
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                )..show(context);
                              }
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
