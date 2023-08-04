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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 80, bottom: 20, left: 1, right: 40),
                child: ListTile(
                  leading: const Icon(
                    Icons.arrow_back,
                    color: const Color.fromARGB(255, 7, 107, 132),
                  ),
                  onTap: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const Home()));
                  },
                ),
              ),
              //     Padding(
              //   padding:
              //       const EdgeInsets.only(top: 80, bottom: 20, left: 1, right: 40),
              //   child: ListTile(
              //     leading: const Icon(
              //       Icons.edit_square,
              //       color: const Color.fromARGB(255, 7, 107, 132),
              //     ),
              //     onTap: () {
              //       // Navigator.pushReplacement(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (context) => const Home()));
              //     },
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
