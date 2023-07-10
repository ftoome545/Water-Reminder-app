import 'package:flutter/material.dart';
import '../screens/start_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListTile(
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
          Padding(
            padding: EdgeInsets.all(50.0),
            child: SizedBox(
              width: 295,
              height: 238,
              child: Card(
                color: Color.fromRGBO(0, 200, 250, 0.415),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
