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
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
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
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        indicatorColor: Color.fromARGB(218, 220, 239, 249),
        backgroundColor: const Color.fromARGB(255, 7, 107, 132),
        height: 60,
        selectedIndex: index,
        onDestinationSelected: (index) => setState(() => this.index = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
            selectedIcon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}
