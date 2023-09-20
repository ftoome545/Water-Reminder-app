import 'package:flutter/cupertino.dart';

class SharedDataModel extends ChangeNotifier {
  double weight;
  String bedtime;
  String wakeuptime;
  String unit;
  SharedDataModel(this.weight, this.bedtime, this.wakeuptime, this.unit);
  // String _sharedValue = '';

  // String get sharedValue => _sharedValue;

  void updateSharedValue(double newWeight, String newbedtime,
      String newWakeuptime, String newUnit) {
    weight = newWeight;
    bedtime = newbedtime;
    wakeuptime = newWakeuptime;
    unit = newUnit;
    notifyListeners();
  }
}
