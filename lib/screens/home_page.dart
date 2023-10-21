import 'package:flutter/material.dart';
import 'package:water_reminder_app/screens/home.dart';
import 'package:water_reminder_app/screens/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.weight,
    required this.unit,
    required this.bedTime,
    required this.wakeUpTime,
  }) : super(key: key);

  final double weight;
  final String unit;
  final String bedTime;
  final String wakeUpTime;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int curentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Home(
          weight: widget.weight,
          unit: widget.unit,
          bedTime: widget.bedTime,
          wakeUpTime: widget.wakeUpTime),
      ProfilePage(
        userBedTime: widget.bedTime,
        userWakeUpTime: widget.wakeUpTime,
        userWeight: widget.weight,
        weightUnit: widget.unit,
      ),
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
        selectedItemColor: Color.fromARGB(255, 102, 217, 246),
        backgroundColor: const Color.fromARGB(255, 7, 107, 132),
        items: [
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
