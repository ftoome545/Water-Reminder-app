import 'package:flutter/material.dart';
import '../screens/add_user_info.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 98.0,
              left: 34.0,
              right: 88.0,
              bottom: 18.0,
            ),
            child: const Text(
              "Hi, I'm a water reminder system",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 18.0,
              left: 34.0,
              right: 50.0,
              bottom: 62.0,
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
              top: 62,
              left: 62,
              right: 89,
            ),
            child: SizedBox(
              width: 309,
              height: 59,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      backgroundColor: Color.fromARGB(255, 7, 107, 132)),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => const AddUserInfo());
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
