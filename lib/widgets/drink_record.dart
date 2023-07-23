import 'package:flutter/material.dart';

class DrinkRecord extends StatelessWidget {
  const DrinkRecord({
    super.key,
    required this.time,
    required this.amountOfWater,
    required this.onTab,
  });

  final String time;
  final String amountOfWater;
  final Function onTab;

  void actionPopUpItemSelected(String value) {
    String message;
    if (value == 'edit') {
      message = 'You selected edit item ';
      // You can navigate the user to edit page.
    } else if (value == 'delete') {
      message = 'You selected delete item ';
      // You can delete the item.
    } else {
      message = 'Not implemented';
    }
    print(message);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22),
      child: ListTile(
        title: Text(amountOfWater),
        trailing: PopupMenuButton(
          onSelected: (value) {
            print('You Click on po up menu item');
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
        onTap: onTab(),
      ),
    );
  }
}
