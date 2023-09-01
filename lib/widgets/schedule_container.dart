import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ScheduleContainer extends StatelessWidget {
  const ScheduleContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 298,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 7, 107, 132),
      ),
      child: Column(children: [
        Row(
          children: [
            Column(
              children: [
                Text(
                  '01:40 PM',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Everyday',
                  style: TextStyle(color: Colors.white, fontSize: 10),
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
                  enabledThumbColor: Color.fromARGB(202, 45, 181, 255),
                  enabledTrackColor: Color.fromARGB(138, 45, 181, 255),
                  disabledThumbColor: Color.fromARGB(130, 0, 0, 0),
                  disabledTrackColor: Color.fromARGB(85, 0, 0, 0),
                ),
                InkWell(
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Color.fromARGB(202, 45, 181, 255),
                  ),
                  onTap: () {},
                )
              ],
            )
          ],
        ),
      ]),
    );
  }
}
