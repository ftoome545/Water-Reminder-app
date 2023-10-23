import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder_app/widgets/database.dart';

class IntakeGoalDialog extends StatefulWidget {
  const IntakeGoalDialog({super.key});

  @override
  State<IntakeGoalDialog> createState() => _IntakeGoalDialogState();
}

class _IntakeGoalDialogState extends State<IntakeGoalDialog> {
  late SharedPreferences sharedPreferences;
  final _intakeGoalController = TextEditingController();

  @override
  void dispose() {
    _intakeGoalController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _intakeGoalController.text =
        Provider.of<UserDataProvider>(context, listen: false)
            .getIntakeGoal()
            .toString();
    getData();
  }

  getData() async {
    final userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userDataProvider.intakeGoal = sharedPreferences.getDouble('intakeGoal')!;
    });
  }

  setData() async {
    final intakeGoal =
        Provider.of<UserDataProvider>(context, listen: false).intakeGoal;
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setDouble('intakeGoal', intakeGoal);
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
              const Text('Add the new intake goal'),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 44,
                width: 90,
                child: TextField(
                  controller: _intakeGoalController,
                  decoration: InputDecoration(
                    hintText: '1980 ml',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 7, 107, 132),
                          width: 2,
                        )),
                  ),
                  onChanged: (value) {
                    userDataModel.intakeGoal = double.parse(value);
                  },
                ),
              ),
              const SizedBox(
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
                    const SizedBox(
                      width: 80,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'OK',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 7, 107, 132),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              userDataModel.setIntakeGoal(double.parse(
                                  userDataModel.intakeGoal.toString()));
                              Navigator.pop(context);
                            }),
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
