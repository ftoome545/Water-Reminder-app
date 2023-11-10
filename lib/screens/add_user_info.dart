import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:water_reminder_app/screens/home_page.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:water_reminder_app/widgets/responsive_container.dart';

class AddUserInfo extends StatefulWidget {
  const AddUserInfo({super.key});

  @override
  State<AddUserInfo> createState() => _AddUserInfoState();
}

enum Gender { male, female }

class _AddUserInfoState extends State<AddUserInfo> {
  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Gender? _gender = Gender.male;
  String _unit = 'pounds';
  double _weight = 0;
  TimeOfDay _bedtime = const TimeOfDay(hour: 09, minute: 30);
  TimeOfDay _wakeUptime = const TimeOfDay(hour: 05, minute: 24);
  bool _formValid = false;
  String bedTimeInString = '09:00 PM';
  String wakeUpINString = '04:50 AM';
  void _validateForm() {
    if (_gender == null ||
        _weight == 0 ||
        wakeUpINString == '' ||
        bedTimeInString == '') {
      _formValid = false;
    } else {
      _formValid = true;
    }
  }

  void showBedtimeDialog() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _bedtime,
    );

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
      _bedtime = newTime;
      int hour = _bedtime.hour;
      int minute = _bedtime.minute;
      String formattedTime = DateFormat('hh:mm a').format(DateTime(
          selectedTime.year,
          selectedTime.month,
          selectedTime.day,
          hour,
          minute));
      bedTimeInString = formattedTime;
      print('formattedTime: $formattedTime timeInString: $bedTimeInString');
    });
  }

  void showWakeUpDialog() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _wakeUptime,
    );

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
      _wakeUptime = newTime;
      int hour = _wakeUptime.hour;
      int minute = _wakeUptime.minute;
      String formattedTime = DateFormat('hh:mm a').format(DateTime(
          selectedTime.year,
          selectedTime.month,
          selectedTime.day,
          hour,
          minute));
      wakeUpINString = formattedTime;
      print('formattedTime: $formattedTime wakeUpINString: $wakeUpINString');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ResponsiveContainer(
              child: const Padding(
                padding: EdgeInsets.only(top: 38, left: 24),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Gender',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 24,
                right: 150,
              ),
              child: Column(
                children: <Widget>[
                  RadioListTile<Gender>(
                    activeColor: const Color.fromARGB(255, 7, 107, 132),
                    title: const Text('Male'),
                    value: Gender.male,
                    groupValue: _gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                  RadioListTile<Gender>(
                    activeColor: const Color.fromARGB(255, 7, 107, 132),
                    title: const Text('Female'),
                    value: Gender.female,
                    groupValue: _gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 35, right: 84),
              child: Row(
                children: [
                  const Text(
                    'Weight',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0),
                    child: DropdownButton<String>(
                      iconEnabledColor: const Color.fromARGB(255, 7, 107, 132),
                      value: _unit,
                      items: <String>['pounds', 'kilograms']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _unit = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 44,
                right: 150,
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText:
                        _unit == 'pounds' ? 'Weight (lbs)' : 'Weight (kg)'),
                onChanged: (String newValue) {
                  setState(() {
                    _weight = double.tryParse(newValue) ?? 0;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38, left: 35, right: 80),
              child: ListTile(
                title: const Text(
                  'Wake-up time',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text('${_bedtime.hour}:${_bedtime.minute}'),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    wakeUpINString,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                onTap: () {
                  showWakeUpDialog();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38, left: 35, right: 80),
              child: ListTile(
                title: const Text(
                  'Bedtime',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text('${_bedtime.hour}:${_bedtime.minute}'),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    bedTimeInString,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                onTap: () {
                  showBedtimeDialog();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 30,
                left: 57,
                right: 56,
              ),
              child: SizedBox(
                width: 300,
                height: 54.79,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        backgroundColor: Color.fromARGB(255, 7, 107, 132)),
                    onPressed: () {
                      _validateForm();
                      if (_formValid) {
                        if (user != null) {
                          String firebaseAuthId = user!.uid;
                          String stringGender =
                              _gender.toString().split(".").last;
                          _firestore
                              .collection('users')
                              .doc(firebaseAuthId)
                              .set({
                            'bedtime': bedTimeInString,
                            'gender': stringGender,
                            'wake-up time': wakeUpINString,
                            'weight': _weight,
                            'unit': _unit,
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage(
                                    weight: _weight,
                                    unit: _unit,
                                    bedTime: bedTimeInString,
                                    wakeUpTime: wakeUpINString,
                                  )));
                        }
                      } else {
                        Flushbar(
                          title: "Warning",
                          message: "Please fill in all the form items.",
                          duration: Duration(seconds: 4),
                          backgroundColor: Colors.red,
                        )..show(context);
                      }
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
