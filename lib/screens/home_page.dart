import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final pages = [
    const Center(
        child: Text(
      'Welcom to Home Page',
      style: TextStyle(fontSize: 37),
    )),
    const Center(
        child: Text(
      'Profile Page',
      style: TextStyle(fontSize: 37),
    )),
  ];
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 7, 96, 168),
          title: const Text(
            'Water reminder',
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
        ),
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
      ),
    );
  }
}