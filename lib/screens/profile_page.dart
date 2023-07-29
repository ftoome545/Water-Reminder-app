import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage(
      {super.key,
      required this.weightUnit,
      required this.userWeight,
      required this.userBedTime,
      required this.userWakeUpTime});
  final String weightUnit;
  final double userWeight;
  final String userBedTime;
  final String userWakeUpTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            userWakeUpTime,
            style: TextStyle(fontSize: 37),
          )),
          Center(
              child: Text(
            userBedTime,
            style: TextStyle(fontSize: 37),
          )),
          Center(
              child: Text(
            '$userWeight',
            style: TextStyle(fontSize: 37),
          )),
          Center(
              child: Text(
            weightUnit,
            style: TextStyle(fontSize: 37),
          )),
        ],
      ),
    );
  }
}
