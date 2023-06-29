import 'package:flutter/material.dart';

class AddUserInfo extends StatelessWidget {
  const AddUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 116, 224, 251),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 38, left: 35, right: 284),
          child: Text(
            'Gender',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }
}
