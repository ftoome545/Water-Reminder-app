import 'package:flutter/material.dart';

class AddUserInfo extends StatefulWidget {
  const AddUserInfo({super.key});

  @override
  State<AddUserInfo> createState() => _AddUserInfoState();
}

enum Gender { male, female }

class _AddUserInfoState extends State<AddUserInfo> {
  Gender? _gender = Gender.male;
  String _unit = 'pounds';
  double _wieght = 0;
  String _briod = 'AM';
  late String _time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 197, 239, 250),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  activeColor: const Color.fromARGB(255, 7, 107, 132),
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
            padding: EdgeInsets.only(top: 15, left: 35, right: 84),
            child: Row(
              children: [
                Text(
                  'Weight',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: dropdownButtonFunction(_unit, 'pounds', 'kilograms'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 24,
              right: 150,
            ),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText:
                      _unit == 'pounds' ? 'Wieght (lbs)' : 'Wieght (kg)'),
              onChanged: (String newValue) {
                setState(() {
                  _wieght = double.tryParse(newValue) ?? 0;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 38, left: 35, right: 80),
            child: Row(
              children: [
                Text(
                  'Wake-up time',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: dropdownButtonFunction(_briod, 'AM', 'PM'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 24,
              right: 150,
            ),
            child: TextFormField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  labelText: _briod == 'AM' ? '05:30 AM' : '11:00 PM'),
              onChanged: (String newValue) {
                setState(() {
                  _time = String.fromCharCode(newValue as int) ?? '02:55 PM';
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 38, left: 35, right: 80),
            child: Row(
              children: [
                Text(
                  'Bedtime',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: dropdownButtonFunction(_briod, 'AM', 'PM'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 24,
              right: 150,
            ),
            child: TextFormField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  labelText: _briod == 'AM' ? '05:30 AM' : '11:00 PM'),
              onChanged: (String newValue) {
                setState(() {
                  _time = String.fromCharCode(newValue as int) ?? '02:55 PM';
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 48,
              left: 57,
              right: 56,
            ),
            child: SizedBox(
              width: 209,
              height: 54.79,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      backgroundColor: Color.fromARGB(255, 7, 107, 132)),
                  onPressed: () {},
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
    );
  }

  DropdownButton<String> dropdownButtonFunction(
      String one, String two, String three) {
    return DropdownButton<String>(
      value: one,
      onChanged: (String? newValue) {
        setState(() {
          one = newValue!;
        });
      },
      items: <String>[two, three].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
