import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EmailAlertDialog extends StatefulWidget {
  const EmailAlertDialog({
    super.key,
  });

  @override
  State<EmailAlertDialog> createState() => _EmailAlertDialogState();
}

class _EmailAlertDialogState extends State<EmailAlertDialog> {
  final _emailController = TextEditingController();
  final _emailConfirmController = TextEditingController();

  late String email_1;
  late String email_2;

  @override
  void dispose() {
    _emailController.dispose();
    _emailConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Reset Email',
        style: TextStyle(
          color: Color.fromARGB(255, 7, 107, 132),
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Add the email'),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 44,
              width: 90,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'user@name2.com',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: const Color.fromARGB(255, 7, 107, 132),
                        width: 2,
                      )),
                ),
                onChanged: (value) {
                  email_1 = value;
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text('Confirm the email:'),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 44,
              width: 90,
              child: TextField(
                controller: _emailConfirmController,
                decoration: InputDecoration(
                  hintText: 'user@name2.com',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: const Color.fromARGB(255, 7, 107, 132),
                        width: 2,
                      )),
                ),
                onChanged: (value) {
                  email_2 = value;
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
                            // Navigator.pushNamed(context, logInPage);
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
