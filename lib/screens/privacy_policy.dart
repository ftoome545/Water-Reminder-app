import 'package:flutter/material.dart';
import 'package:water_reminder_app/widgets/responsive_container.dart';

// ignore: must_be_immutable
class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 107, 132),
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SingleChildScrollView(
            child: ResponsiveContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 50, bottom: 13, right: 25, left: 25),
                    child: Center(
                      child: Text(
                        'Android App Privacy Policy',
                        style: TextStyle(
                          fontSize: 32,
                          color: Color.fromARGB(255, 7, 107, 132),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 25, left: 15, right: 15, bottom: 5),
                    child: Text(
                      'To make our app work properly, we need sometimes to request some permistions for: \n\n * Access to WIFI for getting user data from the server and for advertisements.\n\n * Allow Notifications. ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
