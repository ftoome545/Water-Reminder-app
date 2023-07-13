import 'package:flutter/material.dart';
import '../screens/start_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int amount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 48.0),
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
          Padding(
            padding: EdgeInsets.only(top: 18, left: 33, right: 33),
            child: SizedBox(
              width: 295,
              height: 238,
              child: Card(
                color: Color.fromRGBO(0, 200, 250, 0.415),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 46, bottom: 21, left: 62, right: 62),
                      child: Text(
                        'Your Drink Goal',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 21, left: 52, right: 52),
                      child: Text(
                        '$amount / 1500ml',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 57, right: 57),
                      child: ListTile(
                        title: Text(
                          '175ml',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        leading: Icon(
                          Icons.coffee_sharp,
                          size: 70,
                        ),
                        onTap: () {
                          setState(() {
                            amount += 175;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 15, bottom: 15, left: 173, right: 173),
            child: Icon(
              Icons.arrow_upward,
              color: const Color.fromARGB(255, 7, 107, 132),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 21, left: 55, right: 55),
            child: Text(
              'Click here to confirm that you drank water',
              style: TextStyle(
                fontSize: 18,
                color: const Color.fromARGB(146, 0, 0, 0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 19, left: 34, right: 164),
            child: ListTile(
              title: Icon(Icons.add_circle_outline),
              leading: Text(
                "Today's drunks",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 155,
              width: 291,
              child: Card(
                  color: Color.fromARGB(255, 220, 239, 249),
                  shadowColor: const Color.fromARGB(14, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 22, right: 22),
                        child: ListTile(
                          title: Text('175ml'),
                          trailing: Text(
                            '...',
                            style: TextStyle(fontSize: 20),
                          ),
                          leading: Text(
                            "03:44 PM ",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 22, right: 22),
                        child: ListTile(
                          title: Text('175ml'),
                          trailing: Text(
                            '...',
                            style: TextStyle(fontSize: 20),
                          ),
                          leading: Text(
                            "03:44 PM ",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
