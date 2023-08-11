import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:water_reminder_app/model/pages_names.dart';
import 'package:water_reminder_app/screens/privacy_policy.dart';
import 'package:water_reminder_app/screens/reminder_schedule.dart';
import 'package:water_reminder_app/screens/reminder_sound.dart';
import 'package:water_reminder_app/widgets/bedtime_dialog.dart';
import 'package:water_reminder_app/widgets/gender_dialog.dart';
import 'package:water_reminder_app/widgets/wakeuptime_dailog.dart';
import '../widgets/email_alert_dialog.dart';
import '../widgets/weight_dialog.dart';
// import 'package:water_reminder_app/model/user_data.dart';

class ProfilePage extends StatefulWidget {
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
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? profileImagePath;
  User? user = FirebaseAuth.instance.currentUser;

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choose Profile Image',
            style: TextStyle(
              color: Color.fromARGB(255, 7, 107, 132),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Take a new photo'),
                  onTap: () {
                    _chooseImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  child: Text('Select from gallery'),
                  onTap: () {
                    _chooseImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEmailResetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EmailAlertDialog();
      },
    );
  }

  void _showGenderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GenderDialog();
      },
    );
  }

  void _showWeightDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WeightDialog();
        });
  }

  void _showBedtimeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BedtimeDialog();
        });
  }

  void _showWakeUpTimeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WakeUpTimeDialog();
        });
  }

  void _chooseImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        profileImagePath = pickedImage.path;
      });
    }
  }

  void getUserEmail() {
    if (user != null) {
      Text(
        '${user!.email}',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              width: 400,
              color: Color.fromRGBO(0, 200, 250, 0.415),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 100, bottom: 15, left: 1, right: 40),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 33, right: 27, bottom: 11),
                          child: InkWell(
                            onTap: () {
                              _showImagePickerDialog();
                            },
                            child: (profileImagePath != null)
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    backgroundImage: FileImage(
                                      File(profileImagePath ?? ''),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Color.fromARGB(255, 7, 107, 132),
                                    ),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 68, left: 5, right: 5, bottom: 26),
                          child: (user != null)
                              ? Text(
                                  '${user!.email}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text('userName'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 23,
                left: 25,
                bottom: 15,
              ),
              child: Text(
                'User information',
                style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(142, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
            ),
            userInformation('Email', '${user!.email}', () {
              _showEmailResetDialog();
            }),
            userInformation('Password', '', () {
              Navigator.pushNamed(context, resetPasswordPage);
            }),
            userInformation('Gender', 'Female', () {
              _showGenderDialog();
            }),
            userInformation('Weight', '${widget.userWeight}', () {
              _showWeightDialog();
            }),
            userInformation('Bedtime', widget.userBedTime, () {
              _showBedtimeDialog();
            }),
            userInformation('Wake-up time', widget.userWakeUpTime, () {
              _showWakeUpTimeDialog();
            }),
            Padding(
              padding: const EdgeInsets.only(
                top: 23,
                left: 25,
                bottom: 15,
              ),
              child: Text(
                'Reminder settings',
                style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(142, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
            ),
            reminderSettings('Reminder schedule', () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ReminderSchedule()));
            }),
            reminderSettings('Reminder sound', () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ReminderSound()));
            }),
            Padding(
              padding: const EdgeInsets.only(
                top: 23,
                left: 25,
                bottom: 15,
              ),
              child: Text(
                'General',
                style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(142, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
            ),
            userInformation('Intake goal', '1980 ml', () {}),
            userInformation('Unit', 'kg, ml', () {}),
            userInformation('Privacy policy', '', () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicy()));
            }),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Padding reminderSettings(String title, Function()? onTab) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 34),
      child: InkWell(
        onTap: onTab,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget userInformation(String title, String data, Function()? ontab) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 34),
      child: InkWell(
        onTap: ontab,
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(width: 100),
            Text(
              data,
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 7, 107, 132),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
