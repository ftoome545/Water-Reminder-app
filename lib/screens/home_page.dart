import 'package:flutter/material.dart';
import 'package:water_reminder_app/screens/home.dart';
import 'package:water_reminder_app/screens/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int curentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const Home(),
      const ProfilePage(),
    ];
    return Scaffold(
      body: pages[curentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            curentIndex = index;
          });
        },
        currentIndex: curentIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 102, 217, 246),
        backgroundColor: const Color.fromARGB(255, 7, 107, 132),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
                size: 30,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
