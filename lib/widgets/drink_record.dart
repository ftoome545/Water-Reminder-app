import 'package:flutter/material.dart';

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
      // You can navigate the user to edit page.
      onEdit();
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
            contentPadding: EdgeInsets.only(left: 8, right: 10),
            // subtitle: Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     nextTime,
            //     style: TextStyle(
            //       fontSize: 18,
            //     ),
            //   ),
            // ),
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
}

// class RecommindedAmount {

//   String calculateRecommendedAmount(double weight, String unit) {
//     if (unit == 'kilograms') {
//       double kiloResult = weight * 30;
//       return kiloResult.round().toString();
//     } else {
//       double pounResult = weight * 0.5;
//       return pounResult.round().toString();
//     }
//   }
// }
