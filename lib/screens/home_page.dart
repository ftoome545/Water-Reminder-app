import 'package:flutter/material.dart';
import '../screens/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final pages = [
    //  Home(),
    const Center(
        child: Text(
      'Profile Page',
      style: TextStyle(fontSize: 37),
    )),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
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
            label: 'Home',
            selectedIcon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}
