import 'package:flutter/material.dart';

class ReminderSchedule extends StatelessWidget {
  const ReminderSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ListTile(
          leading: Icon(
            Icons.arrow_back_ios,
          ),
          onTap: () {},
        ),
        Center(
          child: Text('Reminder Schedule page'),
        ),
      ]),
    );
  }
}
