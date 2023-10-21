import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder_app/widgets/database.dart';

class DrinkRecord extends StatelessWidget {
  const DrinkRecord({
    super.key,
    required this.time,
    required this.amountOfWater,
    required this.onDelete,
    required this.onEdit,
  });

  final String time;
  final String amountOfWater;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  void actionPopUpItemSelected(String value) {
    if (value == 'edit') {
      onEdit();
    } else if (value == 'delete') {
      onDelete();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22),
      child: Consumer<UserDataProvider>(
        builder: (context, userDataModel, child) => Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 8, right: 10),
              title: Text(amountOfWater),
              trailing: PopupMenuButton(
                onSelected: (value) {
                  actionPopUpItemSelected(value);
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(
                          Icons.delete,
                          color: const Color.fromARGB(255, 7, 107, 132),
                        ),
                        title: Text('Delete'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'edit',
                      child: ListTile(
                        leading: Icon(
                          Icons.edit,
                          color: const Color.fromARGB(255, 7, 107, 132),
                        ),
                        title: Text('Edit'),
                      ),
                    ),
                  ];
                },
              ),
              leading: Text(
                time,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {},
            ),
            SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}

class DrinkRecordModel {
  String time;
  String amountOfWater;
  // String nextTime;s
  DrinkRecordModel({
    required this.time,
    required this.amountOfWater,
    // required this.nextTime,
  });
  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'amountOfWater': amountOfWater,
    };
  }

  factory DrinkRecordModel.fromMap(Map<String, dynamic> map) {
    return DrinkRecordModel(
      time: map['time'],
      amountOfWater: map['amountOfWater'],
    );
  }
}
