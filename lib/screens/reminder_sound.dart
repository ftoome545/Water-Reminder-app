import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder_app/screens/home_page.dart';

class ReminderSound extends StatefulWidget {
  const ReminderSound({super.key});

  @override
  State<ReminderSound> createState() => _ReminderSoundState();
}

class _ReminderSoundState extends State<ReminderSound> {
  User? user = FirebaseAuth.instance.currentUser;
  int selectedButtonIndex = -1;
  void playMusic(int musicNumber) {
    final player = AudioPlayer();
    player.play(AssetSource('music-$musicNumber.mp3'));
  }

  Expanded myButton(
      int musicNumber, Color buttonColor, String buttonName, int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 1.0),
        child: SizedBox(
          height: 51,
          width: 298,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 7, 107, 132),
            ),
            onPressed: () {
              setState(() {
                selectedButtonIndex = index;
              });
              playMusic(musicNumber);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Icon(
                    Icons.music_note,
                    color: buttonColor,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    buttonName,
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 20.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 130),
                    child: Visibility(
                        visible: selectedButtonIndex == index,
                        child: Icon(
                          Icons.check,
                          size: 30,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 7, 107, 132),
      //   title: Text(
      //     'Reminder Sound',
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
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
                subtitle: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Reminder sound',
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
              padding: const EdgeInsets.only(
                  top: 100, bottom: 25, left: 31, right: 31),
              child: myButton(1, Colors.white, 'Tone 1', 0),
            ), //here I added a comma instead of a semicolon
            Padding(
              padding: const EdgeInsets.only(bottom: 25, left: 31, right: 31),
              child: myButton(2, Colors.white, 'Tone 2', 1),
            ),
            // myButton(3, Colors.blue, 'Music 3'),
            Padding(
              padding: const EdgeInsets.only(bottom: 25, left: 31, right: 31),
              child: myButton(4, Colors.white, 'Tone 3', 2),
            ),
            // myButton(5, Colors.blue, 'Music 5'),
            Padding(
              padding: const EdgeInsets.only(bottom: 25, left: 31, right: 31),
              child: myButton(6, Colors.white, 'Tone 4', 3),
            ),
            // myButton(7, Colors.blue, 'Music 7'),
          ],
        ),
      ),
    );
  }
}
