// import 'dart:js';
import 'package:flutter/material.dart';
import 'drink_record.dart';

class UserDataProvider extends ChangeNotifier {
  // double intakeGoal = 0;
  late double intakeGoal;
  double amount = 0; //for home page
  ValueNotifier<List<DrinkRecordModel>> items = ValueNotifier([]);

  void initializeItems(String unit) {
    items.value = [
      // DrinkRecordModel(
      //   time: '11:00 AM',
      //   amountOfWater: '${unit == 'kilograms' ? '175 ml' : '6 fl oz'}',
      // ),
    ];
    notifyListeners();
  }

  dynamic calculateRecommendedAmount(String unit, double weight) {
    if (unit == 'kilograms') {
      double kiloResult = weight * 30;
      kiloResult.round().toString();
      intakeGoal = kiloResult;
      return intakeGoal.round();
    } else {
      double pounResult = weight * 0.5;
      pounResult.round().toString();
      intakeGoal = pounResult;
      return intakeGoal.round();
    }
  }

  String changeUnit(String unit) {
    return unit == 'kilograms' ? 'ml' : 'fl oz';
  }

  double getIntakeGoal() {
    return intakeGoal;
  }

  void setIntakeGoal(double goal) {
    intakeGoal = goal;
    notifyListeners();
  }
}
