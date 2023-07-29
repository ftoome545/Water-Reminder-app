import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_reminder_app/screens/home.dart';
import 'package:water_reminder_app/screens/home_page.dart';

class AddUserInfo extends StatefulWidget {
  const AddUserInfo({super.key});

  @override
  State<AddUserInfo> createState() => _AddUserInfoState();
}

enum Gender { male, female }

class _AddUserInfoState extends State<AddUserInfo> {
  final _firestore = FirebaseFirestore.instance;
  Gender? _gender = Gender.male;
  String _unit = 'pounds';
  double _weight = 0;
  String _briod = 'AM';
  String _briodTow = 'PM';
  late String _bedtime;
  late String _wakeUptime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Padding(
              padding: EdgeInsets.only(top: 38, left: 35, right: 280),
              child: Text(
                'Gender',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              child: Row(
                children: [
                  const Text(
                    'Wake-up time',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0),
                    child: DropdownButton<String>(
                      iconEnabledColor: const Color.fromARGB(255, 7, 107, 132),
                      value: _briod,
                      items: <String>['AM', 'PM']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _briod = newValue!;
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
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    labelText: _briod == 'AM' ? '05:30 AM' : '11:00 PM'),
                onChanged: (String newValue) {
                  setState(() {
                    _wakeUptime = newValue;
                    // _time = String.fromCharCode(newValue as String) ?? '02:55 PM';
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38, left: 35, right: 80),
              child: Row(
                children: [
                  const Text(
                    'Bedtime',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0),
                    child: DropdownButton<String>(
                      iconEnabledColor: const Color.fromARGB(255, 7, 107, 132),
                      value: _briodTow,
                      items: <String>['AM', 'PM']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _briodTow = newValue!;
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
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    labelText: _briodTow == 'AM' ? '05:30 AM' : '11:00 PM'),
                onChanged: (String newValue) {
                  setState(() {
                    _bedtime = newValue;
                  });
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
                      String stringGender = _gender.toString().split(".").last;
                      _firestore.collection('users').add({
                        'bedtime': _bedtime,
                        'gender': stringGender,
                        'wake-up time': _wakeUptime,
                        'weight': _weight,
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(
                                weight: _weight,
                                unit: _unit,
                                bedTime: _bedtime,
                                wakeUpTime: _wakeUptime,
                              )));
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
