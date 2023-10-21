import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder_app/widgets/database.dart';

class IntakeGoalDialog extends StatefulWidget {
  const IntakeGoalDialog({super.key});

  @override
  State<IntakeGoalDialog> createState() => _IntakeGoalDialogState();
}

class _IntakeGoalDialogState extends State<IntakeGoalDialog> {
  final _intakeGoalController = TextEditingController();

  late String intakeGoal;

  @override
  void dispose() {
    _intakeGoalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(
      builder: (context, userDataModel, child) => AlertDialog(
        title: const Text(
          'Intake goal',
          style: TextStyle(
            color: Color.fromARGB(255, 7, 107, 132),
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Add the new intake goal'),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 44,
                width: 90,
                child: TextField(
                  // controller: _emailController,
                  decoration: InputDecoration(
                    hintText: '1980 ml',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: const Color.fromARGB(255, 7, 107, 132),
                          width: 2,
                        )),
                  ),
                  onChanged: (value) {
                    intakeGoal = value;
                  },
                ),
              ),
              SizedBox(
                height: 8,
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
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
