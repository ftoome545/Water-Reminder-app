import 'package:flutter/material.dart';

class AddUserInfo extends StatefulWidget {
  const AddUserInfo({super.key});

  @override
  State<AddUserInfo> createState() => _AddUserInfoState();
}

enum Gender { male, female }

class _AddUserInfoState extends State<AddUserInfo> {
  Gender? _gender = Gender.male;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 197, 239, 250),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 38, left: 35, right: 284),
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
                activeColor: Color.fromARGB(255, 7, 107, 132),
                title: Text('Male'),
                value: Gender.male,
                groupValue: _gender,
                onChanged: (Gender? value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
              RadioListTile<Gender>(
                activeColor: Color.fromARGB(255, 7, 107, 132),
                title: Text('Female'),
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
          padding: EdgeInsets.only(top: 15, left: 35, right: 284),
          child: Text(
            'Weight',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }
}
