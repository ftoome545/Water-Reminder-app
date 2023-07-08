import 'package:flutter/material.dart';
import '../screens/signUp_page.dart';
import '../screens/login_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  Widget LoginSignUpBotton(String text, VoidCallback action) {
    return SizedBox(
      height: 41,
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 7, 96, 168),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)), // Background color
        ),
        onPressed: action,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 96, 168),
        title: const Text(
          'Water reminder',
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 50.0, bottom: 58.0, left: 21.0, right: 21.0),
              // child: Image.asset('images/start page image.png'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'images/start page image.png',
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(.8),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 21.0, right: 110.0),
                  child: LoginSignUpBotton('Login', () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 21.0),
                  child: LoginSignUpBotton('SignUp', () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
