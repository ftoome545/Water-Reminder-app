import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../model/pages_names.dart';
import '../widgets/email_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String userName;
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
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 7, 107, 132)),
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(10.0),
              //   child: EmailPassword(
              //     title: 'Full Name',
              //     hint: 'Fatima Hure',
              //     onchanged: (value) {
              //       userName = value;
              //     },
              //     obscureText: false,
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: EmailPassword(
                  // contro: _emailController,
                  title: 'Email',
                  hint: 'user_name@gmail.com',
                  onchanged: (value) {
                    email = value;
                  },
                  obscureText: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: EmailPassword(
                  // contro: _passwordController,
                  title: 'Password',
                  hint: 'Enter your password',
                  onchanged: (value) {
                    password = value;
                  },
                  obscureText: true,
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
                              text: 'Already Member?',
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                              children: [
                                TextSpan(
                                    text: ' Login',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(context, logInPage);
                                      }),
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 130.0,
                          left: 2.0,
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
                                // ignore: unused_local_variable
                                final newUser =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email, password: password);
                                Navigator.pushNamed(context, userDataPage);
                                setState(() {
                                  showSpinner = false;
                                });
                              } on FirebaseAuthException catch (e) {
                                String message;
                                if (e.code == 'email-already-in-use') {
                                  message =
                                      'The email address is already in use by another account';
                                } else if (e.code == 'weak-password') {
                                  message = 'The password is too weak';
                                } else if (e.code == 'invalid-email') {
                                  message = 'The email address is invalid';
                                } else {
                                  message = 'An error occurred';
                                }
                                setState(() {
                                  showSpinner = false;
                                });
                                Flushbar(
                                  duration: const Duration(seconds: 3),
                                  message: message,
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                ).show(context);
                                // print(e);
                              }
                            },
                            child: const Text(
                              'Sign Up',
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
