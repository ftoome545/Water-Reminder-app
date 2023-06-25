import 'package:flutter/material.dart';
import '../widgets/email_password.dart';

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
            Padding(
              padding: const EdgeInsets.all(15.0),
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: EmailPassword(
                email: 'Email',
                hint: 'Enter your email',
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
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
                  height: 280.5,
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 35.0,
                          left: 20.0,
                          right: 35.0,
                          bottom: 35.0,
                        ),
                        child: Text(
                          'New here? Sign Up',
                          style: TextStyle(
                            color: Color.fromARGB(255, 90, 0, 0),
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Login'),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
