import 'package:flutter/material.dart';
import 'package:water_reminder_app/model/pages_names.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _auth = FirebaseAuth.instance;
  late User signUPUser;
  late String userEmail;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signUPUser = user;
        print(signUPUser.email);
        userEmail = signUPUser.email!;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 28.0, bottom: 68),
          //   child: ListTile(
          //     leading: Icon(
          //       Icons.arrow_back,
          //       color: Colors.grey,
          //       size: 29,
          //     ),
          //     onTap: () {
          //       Navigator.pushReplacement(context,
          //           MaterialPageRoute(builder: (context) => const StartPage()));
          //     },
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.only(
              top: 78.0,
              left: 34.0,
              right: 88.0,
              bottom: 36.0,
            ),
            child: Text(
              "Hi, I'm a water reminder system",
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 18.0,
              left: 34.0,
              right: 50.0,
              bottom: 22.0,
            ),
            child: const Text(
              "To keep your body hydrated I need to get some basic information. and I'll keep it save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(102, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 70,
              left: 62,
              right: 62,
              bottom: 20,
            ),
            child: SizedBox(
              width: 309,
              height: 59,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      backgroundColor: const Color.fromARGB(255, 7, 107, 132)),
                  onPressed: () {
                    Navigator.pushNamed(context, addUserDataPage);
                  },
                  child: const Text(
                    "Let's Start",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
