import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder_app/screens/home_page.dart';
import 'package:water_reminder_app/screens/profile_page.dart';
import 'package:water_reminder_app/widgets/responsive_container.dart';

// ignore: must_be_immutable
class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ListTile(
            leading: Icon(
              Icons.arrow_back,
              size: 30,
              color: const Color.fromARGB(255, 7, 107, 132),
            ),
            onTap: () async {
              try {
                if (user != null) {
                  final userDoc = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user!.uid)
                      .get();

                  if (userDoc.exists) {
                    final userData = userDoc.data() as Map<String, dynamic>;

                    final weight = userData['weight'];
                    final unit = userData['unit'];
                    final bedTime = userData['bedtime'];
                    final wakeUpTime = userData['wake-up time'];

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                weight: weight,
                                unit: unit,
                                bedTime: bedTime,
                                wakeUpTime: wakeUpTime)));
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
              }
            },
            subtitle: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          child: ResponsiveContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 50, bottom: 13, right: 25, left: 25),
                  child: Center(
                    child: Text(
                      'Android App Privacy Policy',
                      style: TextStyle(
                        fontSize: 32,
                        color: const Color.fromARGB(255, 7, 107, 132),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 25, left: 15, right: 15, bottom: 5),
                  child: Text(
                    'To make our app work properly, we need sometimes to request some permistions for: \n\n * Access to WIFI for getting user data from the server.\n\n * Access to phone tone for reminder tone. ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
