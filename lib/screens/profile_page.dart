import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder_app/model/pages_names.dart';
import 'package:water_reminder_app/screens/privacy_policy.dart';
import 'package:water_reminder_app/screens/reminder_schedule.dart';
import 'package:water_reminder_app/screens/reminder_sound.dart';
import 'package:water_reminder_app/widgets/bedtime_dialog.dart';
import 'package:water_reminder_app/widgets/database.dart';
import 'package:water_reminder_app/widgets/gender_dialog.dart';
import 'package:water_reminder_app/widgets/intake_goal_dialog.dart';
import 'package:water_reminder_app/widgets/unit_dialog.dart';
import 'package:water_reminder_app/widgets/wakeuptime_dailog.dart';
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
  late double inTakeGoal;
  final _auth = FirebaseAuth.instance;
  String? profileImagePath;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Choose Profile Image',
            style: TextStyle(
              color: Color.fromARGB(255, 7, 107, 132),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Take a new photo'),
                  onTap: () {
                    _chooseImage(ImageSource.camera);
                    Navigator.of(context).pop();
                    setData();
                  },
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  child: const Text('Select from gallery'),
                  onTap: () {
                    _chooseImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                    setData();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // void _showEmailResetDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return EmailAlertDialog();
  //     },
  //   );
  // }

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
          return const BedtimeDialog();
        });
  }

  void _showWakeUpTimeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const WakeUpTimeDialog();
        });
  }

  void _showUnitDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const UnitDialog();
        });
  }

  void _showIntakeGoalDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const IntakeGoalDialog();
        });
  }

  void _chooseImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        profileImagePath = pickedImage.path;
      });
      setData();
    }
  }

  void getUserEmail() {
    if (user != null) {
      Text(
        '${user!.email}',
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      );
    }
  }

  void getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      profileImagePath = sharedPreferences.getString('profileImagePath');
    });
  }

  void setData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('profileImagePath', profileImagePath!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserDataProvider>(
        builder: (context, userDataModel, child) =>
            StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final userData = snapshot.data?.data() as Map<String, dynamic>?;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 250,
                    width: 400,
                    color: const Color.fromRGBO(0, 200, 250, 0.415),
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
                                    top: 15, left: 20, right: 5, bottom: 11),
                                child: InkWell(
                                  onTap: () {
                                    _showImagePickerDialog();
                                    setData();
                                  },
                                  child: (profileImagePath != null)
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.white,
                                          backgroundImage: FileImage(
                                            File(profileImagePath ?? ''),
                                          ),
                                        )
                                      : const CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.person,
                                            size: 40,
                                            color: Color.fromARGB(
                                                255, 7, 107, 132),
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
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const Text('userName'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 34),
                    child: Row(
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 100),
                        Text(
                          user?.email ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 7, 107, 132),
                          ),
                        ),
                      ],
                    ),
                  ),
                  userInformation('Password', '', () {
                    Flushbar(
                      message:
                          'If you want to reset your password click on Reset Password button',
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 15),
                      flushbarPosition: FlushbarPosition.BOTTOM,
                      mainButton: TextButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                            side:
                                const BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, resetPasswordPage);
                        },
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ).show(context);
                  }),
                  userInformation('Gender', userData?['gender'] ?? '', () {
                    _showGenderDialog();
                  }),
                  userInformation(
                      'Weight', userData?['weight']?.round().toString() ?? '',
                      () {
                    // + '${widget.weightUnit}'
                    _showWeightDialog();
                  }),
                  userInformation('Bedtime', userData?['bedtime'] ?? '', () {
                    _showBedtimeDialog();
                  }),
                  userInformation(
                      'Wake-up time', userData?['wake-up time'] ?? '', () {
                    _showWakeUpTimeDialog();
                  }),
                  const Padding(
                    padding: EdgeInsets.only(
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReminderSchedule()));
                  }),
                  reminderSettings('Reminder sound', () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReminderSound()));
                  }),
                  const Padding(
                    padding: EdgeInsets.only(
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
                  userInformation(
                      'Intake goal',
                      // '${userDataModel.calculateRecommendedAmount(widget.weightUnit, widget.userWeight)} ${userDataModel.changeUnit(widget.weightUnit)}',
                      '${userDataModel.intakeGoal.round()} ${userDataModel.changeUnit(widget.weightUnit)}',
                      () {
                    _showIntakeGoalDialog();
                  }),
                  userInformation(
                      'Unit',
                      (userData?['unit'] == 'pounds')
                          ? 'pounds (lbs)'
                          : 'kilograms (kg)', () {
                    _showUnitDialog();
                  }),
                  userInformation('Privacy policy', '', () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicy()));
                  }),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 34),
                    child: RichText(
                      text: TextSpan(
                        text: 'Log out',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            await FirebaseAuth.instance.signOut();
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              startPage,
                              (route) => false,
                            );
                          },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          },
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
          style: const TextStyle(
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
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 100),
            Text(
              data,
              style: const TextStyle(
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
