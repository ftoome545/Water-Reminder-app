import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder_app/screens/home.dart';
import 'package:water_reminder_app/screens/home_page.dart';
import '../model/pages_names.dart';
import '../screens/reset_password.dart';
import '../widgets/email_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:another_flushbar/flushbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late String email;
  late String password;
  bool showSpinner = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                padding: EdgeInsets.all(10.0),
                child: EmailPassword(
                  title: 'Email',
                  contro: _emailController,
                  hint: 'Enter your email',
                  onchanged: (value) {
                    email = value;
                  },
                  obscureText: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: EmailPassword(
                  title: 'Password',
                  contro: _passwordController,
                  hint: 'Enter your password',
                  onchanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 180),
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
                          top: 190.0,
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
                              String email = _emailController.text.trim();
                              String password = _passwordController.text.trim();
                              if (email.isEmpty || password.isEmpty) {
                                setState(() {
                                  showSpinner = false;
                                });
                                Flushbar(
                                  message: "Email and password cannot be empty",
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 3),
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                )..show(context);
                              } else {
                                try {
                                  final user =
                                      await _auth.signInWithEmailAndPassword(
                                          email: email, password: password);
                                  if (user != null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(
                                                weight: 99,
                                                unit: 'kilograms',
                                                bedTime: '10:00 pm',
                                                wakeUpTime: '06:20 am')));
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

                                  Flushbar(
                                    message: message,
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 3),
                                    flushbarPosition: FlushbarPosition.BOTTOM,
                                  )..show(context);
                                }
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
