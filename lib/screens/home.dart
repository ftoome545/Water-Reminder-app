import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder_app/widgets/responsive_container.dart';
import '../widgets/drink_record.dart';

class Home extends StatefulWidget {
  final double weight;
  final String unit;
  final String bedTime;
  final String wakeUpTime;
  Home({
    required this.weight,
    required this.unit,
    required this.bedTime,
    required this.wakeUpTime,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // static const _amountAdded = 'amount';
  // static const _recomendedWaterAmount = 'recommendedAmount';
  // static const _item = 'recordItem';

  late ValueNotifier<List<DrinkRecordModel>> _items;
  double amount = 0;
  late double recommendedAmount;

  String _calculateRecommendedAmount() {
    if (widget.unit == 'kilograms') {
      double kiloResult = widget.weight * 30;
      return kiloResult.round().toString();
    } else {
      double pounResult = widget.weight * 0.5;
      return pounResult.round().toString();
    }
  }

  void initState() {
    super.initState();
    // _saveData();
    // _getData();
    amount;
    // recommendedAmount = _calculateRecommendedAmount();
    _items = ValueNotifier([
      DrinkRecordModel(
        time: '11:00 AM',
        amountOfWater: '${widget.unit == 'kilograms' ? '175 ml' : '6 fl oz'}',
      ),
    ]);
  }

  // void _saveData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setDouble(_amountAdded, amount);
  //   prefs.setDouble(_recomendedWaterAmount, recommendedAmount);
  //   prefs.setStringList(_item, _items as List<String>);
  // }

  // void _getData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.getDouble(_amountAdded) ?? amount;
  //   prefs.getDouble(_recomendedWaterAmount) ?? recommendedAmount;
  //   prefs.getStringList(_item) ?? _items;
  // }

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
                        color: const Color.fromARGB(255, 7, 107, 132),
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
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        backgroundColor: const Color.fromARGB(255, 7, 107, 132),
                      ),
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
    // final args = ModalRoute.of(context)!.settings.arguments as Home;
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
                          '${amount.round()} / ${_calculateRecommendedAmount()} ${widget.unit == 'kilograms' ? 'ml' : 'oz'}',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      //coffee ListTile button
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, left: 57, right: 57),
                        child: ResponsiveContainer(
                          child: ListTile(
                            title: Text(
                              // '${widget.unit == 'kilograms' ? '175 ml' : '6 fl oz'}',
                              changeUnit(),
                              style: TextStyle(
                                fontSize: 17,
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
          ResponsiveContainer(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
              child: Text(
                'Click here to confirm that you drank water',
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(146, 0, 0, 0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 5,
              left: 15,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Today's records",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15),
            child: ResponsiveContainer(
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
    );
  }
}
