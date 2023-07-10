import 'package:flutter/material.dart';
import '../screens/start_page.dart';
import '../screens/add_user_info.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0, bottom: 50),
            child: ListTile(
              leading: Icon(
                Icons.arrow_back,
                color: Colors.grey,
                size: 29,
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const StartPage()));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 78.0,
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
              top: 52,
              left: 62,
              right: 62,
              bottom: 99,
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddUserInfo()));
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
