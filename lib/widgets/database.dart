// import 'dart:js';
import 'package:flutter/material.dart';
import 'drink_record.dart';

class UserDataProvider extends ChangeNotifier {
  double amount = 0; //for home page
  ValueNotifier<List<DrinkRecordModel>> items = ValueNotifier([]);

  void initializeItems(String unit) {
    items.value = [
      DrinkRecordModel(
        time: '11:00 AM',
        amountOfWater: '${unit == 'kilograms' ? '175 ml' : '6 fl oz'}',
      ),
    ];
    notifyListeners();
  }

  String calculateRecommendedAmount(String unit, double weight) {
    if (unit == 'kilograms') {
      double kiloResult = weight * 30;
      return kiloResult.round().toString();
    } else {
      double pounResult = weight * 0.5;
      return pounResult.round().toString();
    }
  }

  String changeUnit(String unit) {
    return unit == 'kilograms' ? 'ml' : 'fl oz';
  }

  void newIntakeGoal(String newGoal) {}
}
