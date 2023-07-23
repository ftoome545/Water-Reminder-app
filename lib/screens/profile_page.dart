import 'package:flutter/material.dart';
import 'package:water_reminder_app/screens/home.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 548.0),
            child: ListTile(
              leading: Icon(
                Icons.arrow_back,
                color: const Color.fromARGB(255, 7, 107, 132),
                size: 29,
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                              weight: 88,
                              unit: 'kg',
                            )));
              },
            ),
          ),
          const Center(
              child: Text(
            'Profile Page',
            style: TextStyle(fontSize: 37),
          )),
        ],
      ),
    );
  }
}
