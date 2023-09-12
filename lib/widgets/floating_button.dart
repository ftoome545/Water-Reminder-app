import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatefulWidget {
  final Function addSchdule;
  FloatingButton({required this.addSchdule});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  String _briod = 'AM';
  // ignore: unused_field
  late String _setTime;
  final _setTimeController = TextEditingController();

  @override
  void dispose() {
    _setTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Reminder time',
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
                    'Type in time',
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
                controller: _setTimeController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    labelText: _briod == 'AM' ? '05:30 AM' : '11:00 PM'),
                onChanged: (String newValue) {
                  setState(() {
                    _setTime = newValue;
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
                          String t = _setTimeController.text.trim();
                          if (t.isEmpty) {
                            Flushbar(
                              message: 'The item cannot be empty',
                              duration: const Duration(seconds: 3),
                              flushbarPosition: FlushbarPosition.BOTTOM,
                              backgroundColor: Colors.red,
                            ).show(context);
                          } else {
                            widget.addSchdule(_setTime);
                            Navigator.pop(context);
                          }
                        },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container viewSchedule() {
    return Container(
      height: 80,
      width: 298,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 7, 107, 132),
      ),
      child: Text('Setted time'),
    );
  }
}
