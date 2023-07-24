import 'package:flutter/material.dart';

class DrinkRecord extends StatelessWidget {
  const DrinkRecord({
    super.key,
    required this.time,
    required this.amountOfWater,
    required this.onDelete,
  });

  final String time;
  final String amountOfWater;
  final VoidCallback onDelete;

  void actionPopUpItemSelected(String value) {
    if (value == 'edit') {
      // You can navigate the user to edit page.
    } else if (value == 'delete') {
      // You can delete the item.
      onDelete();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(),
            title: Text(amountOfWater),
            trailing: PopupMenuButton(
              onSelected: (value) {
                actionPopUpItemSelected(value);
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
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
    );
  }
}

class DrinkRecordModel {
  final String time;
  final String amountOfWater;
  DrinkRecordModel({
    required this.time,
    required this.amountOfWater,
  });
}
