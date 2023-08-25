import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UnitDialog extends StatefulWidget {
  const UnitDialog({super.key});

  @override
  State<UnitDialog> createState() => _UnitDialogState();
}

enum Unit { kilograms, pounds }

class _UnitDialogState extends State<UnitDialog> {
  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Unit? _unit = Unit.kilograms;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Unit',
        style: TextStyle(
          color: Color.fromARGB(255, 7, 107, 132),
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            RadioListTile<Unit>(
              activeColor: const Color.fromARGB(255, 7, 107, 132),
              title: const Text('kilograms (kg)'),
              value: Unit.kilograms,
              groupValue: _unit,
              onChanged: (Unit? value) {
                setState(() {
                  _unit = value;
                });
              },
            ),
            RadioListTile<Unit>(
              activeColor: const Color.fromARGB(255, 7, 107, 132),
              title: const Text('pounds (lbs)'),
              value: Unit.pounds,
              groupValue: _unit,
              onChanged: (Unit? value) {
                setState(() {
                  _unit = value;
                });
              },
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
                            if (user != null) {
                              String firebaseAuthId = user!.uid;
                              print(user!.email);
                              print(firebaseAuthId);
                              _firestore
                                  .collection('users')
                                  .doc(firebaseAuthId)
                                  .update({'unit': _unit}).then((value) {
                                print('Document updated successfully!');
                              }).catchError((error) {
                                print('Error updating document: $error');
                              });
                              Navigator.pop(context);
                              // }
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
