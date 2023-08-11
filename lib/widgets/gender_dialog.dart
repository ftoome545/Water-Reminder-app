import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GenderDialog extends StatefulWidget {
  const GenderDialog({super.key});

  @override
  State<GenderDialog> createState() => _GenderDialogState();
}

enum Gender { male, female }

class _GenderDialogState extends State<GenderDialog> {
  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Gender? _gender = Gender.male;
  bool _formValid = false;

  void _validateForm() {
    if (_gender == null) {
      _formValid = false;
    } else {
      _formValid = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Gender',
        style: TextStyle(
          color: Color.fromARGB(255, 7, 107, 132),
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
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
                            // _validateForm();
                            if (user != null) {
                              String firebaseAuthId = user!.uid;
                              print(user!.email);
                              print(firebaseAuthId);
                              // if (_formValid) {
                              String stringGender =
                                  _gender.toString().split(".").last;
                              _firestore
                                  .collection('users')
                                  .doc(firebaseAuthId)
                                  .update({'gender': stringGender}).then(
                                      (value) {
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

// _firestore.collection('users').get().then((querySnapshot) {
//   querySnapshot.docs.forEach((doc) {
//     print(doc.data());
//   });
// }).catchError((error) {
//   print('Error getting documents: $error');
// });