import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_reminder_app/widgets/responsive_container.dart';
import '../model/scheduleTimes.dart';
import '../widgets/schedule_container.dart';

class ReminderSchedule extends StatefulWidget {
  const ReminderSchedule({super.key});

  @override
  State<ReminderSchedule> createState() => _ReminderScheduleState();
}

class _ReminderScheduleState extends State<ReminderSchedule> {
  // void _showTimeDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return FloatingButton(
  //           addSchdule: (newTime) {
  //             setState(() {
  //               scheduleTimes.add(newTime.toString());
  //             });
  //           },
  //         );
  //       });
  // }

  void _showTimeDialog() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: setTime,
    );
    if (newTime == null) return;

    final now = DateTime.now();
    final selectedTime = DateTime(
      now.year,
      now.month,
      now.day,
      newTime.hour,
      newTime.minute,
    );

    setState(() {
      setState(() {
        setTime = newTime;
        int hour = setTime.hour;
        int minute = setTime.minute;
        String formattedTime = DateFormat('hh:mm a').format(DateTime(
            selectedTime.year,
            selectedTime.month,
            selectedTime.day,
            hour,
            minute));
        scheduleTimes.add(formattedTime);
      });
    });
  }

  void _deleteScheduleContainer(String time) {
    setState(() {
      scheduleTimes.remove(time);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 107, 132),
        title: const Text('Reminder schedule'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTimeDialog();
        },
        backgroundColor: const Color.fromARGB(255, 8, 179, 222),
        //original color for the flating button is Color.fromARGB(255, 8, 166, 205),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var time in scheduleTimes)
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 13),
                child: ResponsiveContainer(
                    child: ScheduleContainer(
                  time: time,
                  onDeleteSchedule: () {
                    _deleteScheduleContainer(time);
                  },
                )),
              ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
