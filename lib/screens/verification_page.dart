import 'package:flutter/material.dart';
import 'package:water_reminder_app/screens/reset_password.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Align(
              alignment: Alignment.topCenter,
              child: const Text(
                'Forgot Pasword',
                style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold,
                  // color: Color.fromARGB(255, 7, 107, 132),
                ),
              ),
            ),
            leading: const Icon(
              Icons.arrow_back,
              color: const Color.fromARGB(255, 7, 107, 132),
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ResetPassword()));
            },
          ),
          const Center(
            child: Text(
              'This is the Verification page',
              style: TextStyle(fontSize: 37),
            ),
          ),
        ],
      ),
    );
  }
}
