import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ScheduleContainer extends StatefulWidget {
  const ScheduleContainer({
    Key? key,
  }) : super(key: key);

  @override
  _ScheduleContainerState createState() => _ScheduleContainerState();
}

class _ScheduleContainerState extends State<ScheduleContainer> {
  double containerHeight = 80;
  bool isExpanded = false;
  String day = 'Everyday';
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      width: 298,
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
                    '01:40 PM',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      day,
                      style: TextStyle(color: color, fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 180,
              ),
              Column(
                children: [
                  GFToggle(
                    onChanged: (value) {},
                    value: true,
                    enabledThumbColor: Color.fromARGB(255, 8, 179, 222),
                    enabledTrackColor: Color.fromARGB(106, 8, 179, 222),
                    disabledThumbColor: Color.fromARGB(130, 0, 0, 0),
                    disabledTrackColor: Color.fromARGB(85, 0, 0, 0),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Color.fromARGB(255, 8, 179, 222),
                    ),
                    onTap: () {
                      setState(() {
                        if (isExpanded) {
                          containerHeight = 80; // Set to the original height
                          day = 'Everyday';
                          color = Colors.white;
                        } else {
                          containerHeight = 120; // Set to the expanded height
                          day = 'Delete';
                          color = Colors.red;
                        }
                        isExpanded = !isExpanded;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          if (isExpanded)
            Container(
              height: 20,
              width: 40,
              color: Colors.amber,
            ),
        ],
      ),
    );
  }
}
