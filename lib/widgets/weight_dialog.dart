import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WeightDialog extends StatefulWidget {
  const WeightDialog({super.key});

  @override
  State<WeightDialog> createState() => _WeightDialogState();
}

class _WeightDialogState extends State<WeightDialog> {
  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String _unit = 'pounds';
  double _weight = 0;

  bool _formValid = false;

  void _validateForm() {
    if (_weight == 0) {
      _formValid = false;
    } else {
      _formValid = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Weight',
        style: TextStyle(
            color: Color.fromARGB(255, 7, 107, 132),
            fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 35, right: 50),
              child: Row(
                children: [
                  const Text(
                    'Weight',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
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
                right: 90,
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
              padding: const EdgeInsets.only(top: 25, left: 81),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                        text: 'Cancel',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(125, 0, 0, 0),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          }),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'OK',
                        style: const TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 7, 107, 132),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _validateForm();
                            if (user != null) {
                              String uid = user!.uid;
                              if (_formValid) {
                                _firestore
                                    .collection('users')
                                    .doc(uid)
                                    .update({'weight': _weight}).then((value) {
                                  print('Document updated successfully!');
                                }).catchError((error) {
                                  print('Error updating document: $error');
                                });
                                Navigator.pop(context);
                              } else {
                                Flushbar(
                                  title: "Warning",
                                  message: "Please fill in the form item.",
                                  duration: Duration(seconds: 4),
                                  backgroundColor: Colors.red,
                                )..show(context);
                              }
                            }
                          }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
