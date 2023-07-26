import 'package:flutter/material.dart';
import 'package:water_reminder_app/screens/profile_page.dart';

import '../widgets/drink_record.dart';

class Home extends StatefulWidget {
  final double weight;
  final String unit;
  Home({
    required this.weight,
    required this.unit,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ValueNotifier<List<DrinkRecordModel>> _items;
  double amount = 0;
  late double recommendedAmount;

  void initState() {
    super.initState();
    _items = ValueNotifier([
      DrinkRecordModel(
        time: '11:0 AM',
        amountOfWater: '${widget.unit == 'kilograms' ? '175 ml' : '6 fl oz'}',
      ),
    ]);
  }

  String changeUnit() {
    return widget.unit == 'kilograms' ? '175 ml' : '6 fl oz';
  }

  void _deleteItem(int index) {
    setState(() {
      _items.value.removeAt(index);
    });
  }

  void _editItem(int index) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        String updatedTime = _items.value[index].time;
        String updatedAmount = _items.value[index].amountOfWater;
        TextEditingController timeController =
            TextEditingController(text: updatedTime);
        TextEditingController amountController =
            TextEditingController(text: updatedAmount);
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 300,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Edit Record',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Time',
                        hintText: 'Enter new time',
                      ),
                      onChanged: (value) {
                        setState(() {
                          updatedTime = value;
                          _items.value[index].time = value;
                        });
                      },
                      controller: timeController,
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Amount of Water',
                        hintText: 'Enter new amount',
                      ),
                      onChanged: (value) {
                        setState(() {
                          updatedAmount = value;
                          _items.value[index].amountOfWater = value;
                        });
                      },
                      controller: amountController,
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      child: Text('Save'),
                      onPressed: () {
                        _items.notifyListeners();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 90, left: 33, right: 33, bottom: 5),
              child: SizedBox(
                width: 295,
                height: 238,
                child: Card(
                  color: Color.fromRGBO(0, 200, 250, 0.415),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 46, bottom: 21, left: 62, right: 62),
                        child: Text(
                          'Your Drink Goal',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 21, left: 52, right: 52),
                        child: Text(
                          '$amount / ${widget.unit == 'kilograms' ? recommendedAmount = widget.weight * 30 : recommendedAmount = widget.weight * 0.5} ${widget.unit == 'kilograms' ? 'ml' : 'oz'}',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      //coffee ListTile button
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 57, right: 57),
                        child: ListTile(
                          title: Text(
                            // '${widget.unit == 'kilograms' ? '175 ml' : '6 fl oz'}',
                            changeUnit(),
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          leading: Icon(
                            Icons.coffee_sharp,
                            size: 70,
                          ),
                          onTap: () {
                            setState(() {
                              widget.unit == 'kilograms'
                                  ? amount += 175
                                  : amount += 6;
                              _items.value.add(DrinkRecordModel(
                                time: TimeOfDay.now().format(context),
                                amountOfWater: changeUnit(),
                              ));
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, left: 173, right: 173),
            child: Icon(
              Icons.arrow_upward,
              color: const Color.fromARGB(255, 7, 107, 132),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 55, right: 55),
            child: Text(
              'Click here to confirm that you drank water',
              style: TextStyle(
                fontSize: 15,
                color: const Color.fromARGB(146, 0, 0, 0),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 15, bottom: 5, left: 15, right: 170),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Today's records",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15),
              child: SizedBox(
                height: 155,
                width: 350,
                //today's records card
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Color.fromARGB(255, 220, 239, 249),
                  shadowColor: const Color.fromARGB(14, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ValueListenableBuilder<List<DrinkRecordModel>>(
                    valueListenable: _items,
                    builder: (context, items, child) {
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 15),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return DrinkRecord(
                            time: items[index].time,
                            amountOfWater: items[index].amountOfWater,
                            onDelete: () {
                              _deleteItem(index);
                            },
                            onEdit: () {
                              _editItem(index);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Color.fromARGB(218, 220, 239, 249),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: const Color.fromARGB(255, 7, 107, 132),
        height: 60,
        // selectedIndex: index,
        onDestinationSelected: (value) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
            selectedIcon: Icon(
              Icons.home,
              color: const Color.fromARGB(255, 7, 107, 132),
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
            ),
            label: 'Profile',
            selectedIcon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}
