import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:water_reminder_app/model/scheduleTimes.dart';
import 'package:water_reminder_app/services/notify_service.dart';

class ScheduleContainer extends StatefulWidget {
  final String time;
  final VoidCallback onDeleteSchedule;
  ScheduleContainer({required this.time, required this.onDeleteSchedule});

  @override
  _ScheduleContainerState createState() => _ScheduleContainerState();
}

class _ScheduleContainerState extends State<ScheduleContainer> {
  // Padding ;
  bool notify = false;
  double containerHeight = 80;
  bool isExpanded = false;
  String day = 'Everyday';
  Color textColor = Colors.white;
  Icon containerIcons = Icon(
    Icons.keyboard_arrow_down,
    color: Color.fromARGB(255, 8, 179, 222),
  );

  String getRemainingDays() {
    List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    List<String> remainingDayNames = [];

    for (int i = 0; i < selectedDays.length; i++) {
      if (!selectedDays[i]) {
        remainingDayNames.add(days[i]);
      }
    }

    if (remainingDayNames.isEmpty) {
      return 'Everyday';
    } else {
      return remainingDayNames.join(', ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      width: 370,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 7, 107, 132),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.time,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: !isExpanded,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        getRemainingDays(),
                        style: TextStyle(color: textColor, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   width: 140,
              // ),
              Padding(
                padding: EdgeInsets.only(left: 50),
                child: Column(
                  children: [
                    GFToggle(
                      onChanged: (value) {
                        setState(() {
                          notify = value!;
                          if (notify) {
                            // Show a local notification
                            NotificationServices().showScheduledNotification(
                              id: 1,
                              title: "It's time to drink water!",
                              body: 'After drinking, touch the cup to confirm',
                              hour: 4,
                            );
                          }
                        });
                      },
                      value: true,
                      enabledThumbColor: Color.fromARGB(255, 8, 179, 222),
                      enabledTrackColor: Color.fromARGB(106, 8, 179, 222),
                      disabledThumbColor: Color.fromARGB(130, 0, 0, 0),
                      disabledTrackColor: Color.fromARGB(85, 0, 0, 0),
                    ),
                    InkWell(
                      child: containerIcons,
                      onTap: () {
                        setState(() {
                          if (isExpanded) {
                            containerIcons = Icon(
                              Icons.keyboard_arrow_down,
                              color: Color.fromARGB(255, 8, 179, 222),
                            );
                            containerHeight = 90; // Set to the original height
                            textColor = Colors.white;
                          } else {
                            containerIcons = Icon(
                              Icons.keyboard_arrow_up,
                              color: Color.fromARGB(255, 8, 179, 222),
                            );
                            containerHeight = 150; // Set to the expanded height
                          }
                          isExpanded = !isExpanded;
                          Icon(Icons.keyboard_arrow_up);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Visibility(
            visible: isExpanded,
            child: Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      if (isExpanded) weekDays('Sun', 0),
                      SizedBox(
                        width: 5,
                      ),
                      weekDays('Mon', 1),
                      SizedBox(
                        width: 5,
                      ),
                      weekDays('Tue', 2),
                      SizedBox(
                        width: 5,
                      ),
                      weekDays('Wed', 3),
                      SizedBox(
                        width: 5,
                      ),
                      weekDays('Thu', 4),
                      SizedBox(
                        width: 5,
                      ),
                      weekDays('Fri', 5),
                      SizedBox(
                        width: 5,
                      ),
                      weekDays('Sat', 6),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            text: 'Delete',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onDeleteSchedule),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget weekDays(String day, int index) {
    Color containerColor =
        selectedDays[index] ? Colors.white : Color.fromARGB(255, 8, 179, 222);
    Color textColor = selectedDays[index] ? Colors.black : Colors.white;
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: containerColor,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedDays[index] = !selectedDays[index];
          });
        },
        child: Center(
            child: Text(
          day,
          style: TextStyle(color: textColor),
        )),
      ),
    );
  }
}
