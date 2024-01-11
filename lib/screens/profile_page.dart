import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder_app/model/pages_names.dart';
import 'package:water_reminder_app/screens/privacy_policy.dart';
import 'package:water_reminder_app/screens/reminder_schedule.dart';
import 'package:water_reminder_app/widgets/database.dart';
import 'package:water_reminder_app/widgets/gender_dialog.dart';
import 'package:water_reminder_app/widgets/intake_goal_dialog.dart';
import 'package:water_reminder_app/widgets/responsive_container.dart';
import 'package:water_reminder_app/widgets/unit_dialog.dart';
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
  // final _auth = FirebaseAuth.instance;
  String? profileImagePath;
  User? user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;
  TimeOfDay bedtime = const TimeOfDay(hour: 09, minute: 30);
  TimeOfDay wakeUptime = const TimeOfDay(hour: 05, minute: 24);
  late String userAuthID;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userAuthID = FirebaseAuth.instance.currentUser!.uid;
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
        return const GenderDialog();
      },
    );
  }

  void _showWeightDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const WeightDialog();
        });
  }

  void _showTimeDialog(TimeOfDay timeOfDay, String variable) async {
    TimeOfDay? newTime =
        await showTimePicker(context: context, initialTime: bedtime);
    if (newTime == null) return;
    final now = DateTime.now();
    final selectedTime = DateTime(
      now.year,
      now.month,
      now.day,
      newTime.hour,
      newTime.minute,
    );
    setState(() {
      timeOfDay = newTime;
    });
    if (user != null) {
      int hour = timeOfDay.hour;
      int minute = timeOfDay.minute;
      String formattedTime = DateFormat('hh:mm a').format(DateTime(
          selectedTime.year,
          selectedTime.month,
          selectedTime.day,
          hour,
          minute));
      String uid = user!.uid;
      _firestore.collection('users').doc(uid).update({
        variable: formattedTime,
      }).then((value) {
        print('Document updated successfully!');
      }).catchError((error) {
        print('Error updating document: $error');
      });
    }
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
      profileImagePath =
          sharedPreferences.getString('$userAuthID + profileImagePath');
    });
  }

  void setData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        '$userAuthID + profileImagePath', profileImagePath!);
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
                  ResponsiveContainer(
                    child: Container(
                      height: 250,
                      width: 400,
                      color: const Color.fromRGBO(0, 200, 250, 0.415),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 100,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 20, right: 5, bottom: 11),
                                  child: InkWell(
                                    onTap: () {
                                      _showImagePickerDialog();
                                      getData();
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
                    _showTimeDialog(bedtime, 'bedtime');
                  }),
                  userInformation(
                      'Wake-up time', userData?['wake-up time'] ?? '', () {
                    _showTimeDialog(wakeUptime, 'wake-up time');
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
                  // reminderSettings('Reminder sound', () {
                  //   Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const ReminderSound()));
                  // }),
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
                  // userInformation(
                  //     'Intake goal',
                  //     // '${userDataModel.calculateRecommendedAmount(widget.weightUnit, widget.userWeight)} ${userDataModel.changeUnit(widget.weightUnit)}',
                  //     '${userDataModel.intakeGoal.round()} ${userDataModel.changeUnit(widget.weightUnit)}',
                  //     () {
                  //   // _showIntakeGoalDialog();
                  // }),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 34),
                    child: Row(
                      children: [
                        const Text(
                          'Intake goal',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 100),
                        Text(
                          // '${userDataModel.intakeGoal.round()} ${userDataModel.changeUnit(widget.weightUnit)}',
                          (userData?['unit'] == 'pounds')
                              ? '${(userData?['weight'] * 0.5).round()} fl oz'
                              : '${(userData?['weight'] * 30).round()} ml',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 7, 107, 132),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // userInformation(
                  //     'Unit',
                  //     (userData?['unit'] == 'pounds')
                  //         ? 'pounds (lbs)'
                  //         : 'kilograms (kg)', () {
                  //   _showUnitDialog();
                  // }),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 34),
                    child: Row(
                      children: [
                        const Text(
                          'Unit',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 100),
                        Text(
                          (userData?['unit'] == 'pounds')
                              ? 'pounds (lbs)'
                              : 'kilograms (kg)',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 7, 107, 132),
                          ),
                        ),
                      ],
                    ),
                  ),
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
