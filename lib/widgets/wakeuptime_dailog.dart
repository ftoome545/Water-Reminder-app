import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WakeUpTimeDialog extends StatefulWidget {
  const WakeUpTimeDialog({super.key});

  @override
  State<WakeUpTimeDialog> createState() => _WakeUpTimeDialogState();
}

class _WakeUpTimeDialogState extends State<WakeUpTimeDialog> {
  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String _briod = 'AM';
  late String _wakeUpTime;
  final _bedTimeController = TextEditingController();

  @override
  void dispose() {
    _bedTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Wake-up time',
        style: TextStyle(
          color: Color.fromARGB(255, 7, 107, 132),
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 35, right: 30),
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
                right: 90,
              ),
              child: TextFormField(
                controller: _bedTimeController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    labelText: _briod == 'AM' ? '05:30 AM' : '11:00 PM'),
                onChanged: (String newValue) {
                  setState(() {
                    _wakeUpTime = newValue;
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
                            String _wakeUpTime = _bedTimeController.text.trim();
                            if (_wakeUpTime.isEmpty) {
                              Flushbar(
                                message: 'The item cannot be empty',
                                duration: const Duration(seconds: 3),
                                flushbarPosition: FlushbarPosition.BOTTOM,
                                backgroundColor: Colors.red,
                              ).show(context);
                            } else {
                              if (user != null) {
                                String uid = user!.uid;
                                _firestore.collection('users').doc(uid).update({
                                  'wake-up time': _wakeUpTime,
                                }).then((value) {
                                  print('Document updated successfully!');
                                }).catchError((error) {
                                  print('Error updating document: $error');
                                });
                                Navigator.pop(context);
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
