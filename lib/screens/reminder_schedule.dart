import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_reminder_app/screens/home_page.dart';

import '../widgets/schedule_container.dart';

class ReminderSchedule extends StatefulWidget {
  const ReminderSchedule({super.key});

  @override
  State<ReminderSchedule> createState() => _ReminderScheduleState();
}

class _ReminderScheduleState extends State<ReminderSchedule> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: const Color.fromARGB(255, 7, 107, 132),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                    'Reminder schedule',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 31, right: 31, top: 55),
              child: ScheduleContainer(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 31, right: 31, top: 13),
              child: ScheduleContainer(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 31, right: 31, top: 13),
              child: ScheduleContainer(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 31, right: 31, top: 13),
              child: ScheduleContainer(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 31, right: 31, top: 13),
              child: ScheduleContainer(),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
