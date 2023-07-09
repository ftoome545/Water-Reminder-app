import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder_app/screens/reset_password.dart';
import 'package:water_reminder_app/screens/signUp_page.dart';
import '../widgets/email_password.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      color: Color.fromARGB(255, 7, 96, 168)),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: EmailPassword(
                email: 'Email',
                hint: 'Enter your email',
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: EmailPassword(
                email: 'Password',
                hint: 'Enter your password',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 215.0,
              ),
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
                      color: Color.fromARGB(255, 7, 96, 168),
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
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpPage()));
                                    }),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 130.0,
                        left: 55.0,
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
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
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
    );
  }
}
