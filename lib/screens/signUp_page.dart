import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../screens/user_info.dart';
import '../screens/login_page.dart';
import '../widgets/email_password.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/login_image.jpg'),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 7, 96, 168)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: EmailPassword(
                email: 'Full Name',
                hint: 'Fatima Hure',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: EmailPassword(
                email: 'Email',
                hint: 'fatimahure@gmail.com',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: EmailPassword(
                email: 'Password',
                hint: 'Enter your password',
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
                            text: 'Already Member?',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                            children: [
                              TextSpan(
                                  text: ' Login',
                                  style: TextStyle(
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
                                                  const LoginPage()));
                                    }),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 130.0,
                        left: 30.0,
                      ),
                      child: SizedBox(
                        width: 130.8,
                        height: 57.14,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                              side: BorderSide(color: Colors.white, width: 2),
                            ),
                            backgroundColor: Color.fromARGB(255, 7, 107, 132),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserInfoPage()));
                          },
                          child: Text(
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
    );
  }
}
