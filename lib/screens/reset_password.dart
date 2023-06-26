import 'package:flutter/material.dart';
import '../screens/login_page.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

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
          const Center(
            child: Text(
              'here you can reset your password!',
              style: TextStyle(fontSize: 37),
            ),
          ),
        ],
      ),
    );
  }
}
