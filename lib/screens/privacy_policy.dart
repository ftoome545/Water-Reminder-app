import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

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
          child: Text('Privacy Policy page'),
        ),
      ]),
    );
  }
}
