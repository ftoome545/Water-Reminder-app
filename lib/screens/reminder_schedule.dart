import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:water_reminder_app/screens/home_page.dart';
import 'package:water_reminder_app/widgets/responsive_container.dart';
import '../model/scheduleTimes.dart';
import '../widgets/schedule_container.dart';

class ReminderSchedule extends StatefulWidget {
  const ReminderSchedule({super.key});

  @override
  State<ReminderSchedule> createState() => _ReminderScheduleState();
}

class _ReminderScheduleState extends State<ReminderSchedule> {
  User? user = FirebaseAuth.instance.currentUser;

  // void _showTimeDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return FloatingButton(
  //           addSchdule: (newTime) {
  //             setState(() {
  //               scheduleTimes.add(newTime.toString());
  //             });
  //           },
  //         );
  //       });
  // }

  void _showTimeDialog() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: setTime,
    );
    if (newTime == null) return;

    final now = DateTime.now();
    final selectedTime = DateTime(
      now.year,
      now.month,
      now.day,
      newTime.hour,
      newTime.minute,
    );

    setState(() {
      setState(() {
        setTime = newTime;
        int hour = setTime.hour;
        int minute = setTime.minute;
        String formattedTime = DateFormat('hh:mm a').format(DateTime(
            selectedTime.year,
            selectedTime.month,
            selectedTime.day,
            hour,
            minute));
        scheduleTimes.add(formattedTime);
      });
    });
  }

  void _deleteScheduleContainer(String time) {
    setState(() {
      scheduleTimes.remove(time);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTimeDialog();
        },
        backgroundColor: const Color.fromARGB(255, 8, 179, 222),
        //original color for the flating button is Color.fromARGB(255, 8, 166, 205),
        child: const Icon(
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
                leading: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Color.fromARGB(255, 7, 107, 132),
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
                    // ignore: unused_local_variable
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
                subtitle: const Padding(
                  padding: EdgeInsets.all(18.0),
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
            for (var time in scheduleTimes)
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 13),
                child: ResponsiveContainer(
                    child: ScheduleContainer(
                  time: time,
                  onDeleteSchedule: () {
                    _deleteScheduleContainer(time);
                  },
                )),
              ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
