import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EmailAlertDialog extends StatelessWidget {
  const EmailAlertDialog({
    super.key,
  });

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
                decoration: InputDecoration(
                  hintText: 'user@name2.com',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: const Color.fromARGB(255, 7, 107, 132),
                        width: 2,
                      )),
                ),
                onChanged: (value) {},
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
                decoration: InputDecoration(
                  hintText: 'user@name2.com',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: const Color.fromARGB(255, 7, 107, 132),
                        width: 2,
                      )),
                ),
                onChanged: (value) {},
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
