import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder_app/screens/home_page.dart';
import 'package:water_reminder_app/widgets/responsive_container.dart';
import '../model/pages_names.dart';
import '../screens/reset_password.dart';
import '../widgets/email_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/wave_clipper.dart';

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
  bool _isHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          color: const Color.fromARGB(255, 7, 107, 132),
                          height: 200,
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        color: const Color.fromARGB(255, 7, 107, 132),
                        height: 180,
                      ),
                    ),
                  ],
                ),
              ),
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
                padding: const EdgeInsets.all(10.0),
                child: EmailPassword(
                  title: 'Email',
                  contro: _emailController,
                  hint: 'Enter your email',
                  onchanged: (value) {
                    email = value;
                  },
                  obscureText: false,
                  icon: const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: EmailPassword(
                  title: 'Password',
                  contro: _passwordController,
                  hint: 'Enter your password',
                  onchanged: (value) {
                    password = value;
                  },
                  obscureText: _isHidden,
                  icon: InkWell(
                    onTap: _togglePasswordView,
                    child: _isHidden
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ),
              ResponsiveContainer(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 99),
                  child: Align(
                    alignment: Alignment.centerRight,
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
                                      builder: (context) =>
                                          const ResetPassword()));
                            }),
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  ResponsiveContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 230.0,
                            left: 10,
                          ),
                          child: RichText(
                            text: TextSpan(
                                text: 'New here?',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Color.fromARGB(255, 7, 107, 132),
                                ),
                                children: [
                                  TextSpan(
                                      text: ' Sign Up',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 7, 107, 132),
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
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 190.0,
                              left: 18.0,
                            ),
                            child: SizedBox(
                              width: 130.8,
                              height: 57.14,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(255, 7, 107, 132),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  String email = _emailController.text.trim();
                                  String password =
                                      _passwordController.text.trim();
                                  if (email.isEmpty || password.isEmpty) {
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    Flushbar(
                                      message:
                                          "Email and password cannot be empty",
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 3),
                                      flushbarPosition: FlushbarPosition.BOTTOM,
                                    )..show(context);
                                  } else {
                                    try {
                                      final user = await _auth
                                          .signInWithEmailAndPassword(
                                              email: email, password: password);
                                      // ignore: unnecessary_null_comparison
                                      if (user != null) {
                                        final userDoc = await FirebaseFirestore
                                            .instance
                                            .collection('users')
                                            .doc(user.user?.uid)
                                            .get();

                                        if (userDoc.exists) {
                                          final userData = userDoc.data()
                                              as Map<String, dynamic>;

                                          final weight = userData['weight'];
                                          final unit = userData['unit'];
                                          final bedTime = userData['bedtime'];
                                          final wakeUpTime =
                                              userData['wake-up time'];

                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage(
                                                          weight: weight,
                                                          unit: unit,
                                                          bedTime: bedTime,
                                                          wakeUpTime:
                                                              wakeUpTime)));
                                        }
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
                                        flushbarPosition:
                                            FlushbarPosition.BOTTOM,
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
                        ),
                      ],
                    ),
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
