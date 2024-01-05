import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CloudDataProvider extends ChangeNotifier {
  double? weight;
  String? unit;
  String? bedtime;
  String? wakeUptime;

  void fetchUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.uid);

      final userSnapshot = await userDoc.get();

      weight = userSnapshot['weight'] as double;
      unit = userSnapshot['unit'] as String;
      bedtime = userSnapshot['bedtime'] as String;
      wakeUptime = userSnapshot['wake-up time'] as String;
    }

    notifyListeners();
  }
}
