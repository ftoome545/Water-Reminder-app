import 'package:flutter/material.dart';
import '../screens/login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            leading: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
          Center(
            child: Text(
              'SignUp Page',
              style: TextStyle(fontSize: 37.0),
            ),
          ),
        ],
      ),
    );
  }
}
