import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder_app/screens/start_page.dart';
import 'package:water_reminder_app/widgets/database.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder_app/widgets/responsive_container.dart';
import '../ad_id.dart';
import '../widgets/drink_record.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // late ValueNotifier<List<DrinkRecordModel>> _items;
  BannerAd? _bannerAd;
  // bool _isBannerAdReady = false;
  User? user = FirebaseAuth.instance.currentUser;
  late SharedPreferences sharedPreferences;
  late String userAuthID;
  String? unit;
  @override
  void initState() {
    super.initState();

    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userAuthID = currentUser.uid;

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final userDoc =
            FirebaseFirestore.instance.collection('users').doc(user!.uid);

        final userSnapshot = await userDoc.get();
        unit = userSnapshot['unit'] as String;
        final userDataProvider =
            // ignore: use_build_context_synchronously
            Provider.of<UserDataProvider>(context, listen: false);
        userDataProvider.initializeItems(unit ?? '');
        getData();
        _loadAd();
      });
    } else {
      // Handle the case when there is no user logged in
      // For example, redirect to login screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const StartPage()));
      });
    }
  }

  /// Loads a banner ad.
  void _loadAd() {
    final bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }

  void setData() async {
    final userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    final itemList = userDataProvider.items.value
        .map((item) => jsonEncode(item.toMap()))
        .toList();
    sharedPreferences.setStringList('$userAuthID + items', itemList);
    sharedPreferences.setDouble(
        '$userAuthID + amount', userDataProvider.amount);
  }

  void getData() async {
    final userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    sharedPreferences = await SharedPreferences.getInstance();
    final itemList = sharedPreferences.getStringList('$userAuthID + items');
    if (itemList != null) {
      final drinkRecords = itemList
          .map((item) => DrinkRecordModel.fromMap(jsonDecode(item)))
          .toList();
      userDataProvider.items =
          ValueNotifier<List<DrinkRecordModel>>(drinkRecords);
    }

    double? amount = sharedPreferences.getDouble('$userAuthID + amount');
    // if (amount != null) {
    setState(() {
      userDataProvider.amount = amount ?? 0.0;
    });
    // }
  }

  /*
  widget.unit == 'kilograms' 
  ? userDataModel.amount += 175
  : userDataModel.amount += 6;
   */
  // String newAmount(double amount, String currentUnit) {
  //   if (currentUnit == 'kilograms') {
  //     amount = amount * 29.57;
  //     return amount.round().toString();
  //   } else {
  //     amount = amount / 29.57;
  //     return amount.round().toString();
  //   }
  // }

  void _deleteItem(int index, String unit) {
    final userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    setState(() {
      userDataProvider.items.value.removeAt(index);
      unit == 'kilograms'
          ? userDataProvider.amount -= 175
          : userDataProvider.amount -= 6;
    });
    setData();
  }

  // void _editItem(int index) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (BuildContext context) {
  //       final userDataProvider =
  //           Provider.of<UserDataProvider>(context, listen: false);
  //       String updatedTime = userDataProvider.items.value[index].time;
  //       String updatedAmount =
  //           userDataProvider.items.value[index].amountOfWater;
  //       TextEditingController timeController =
  //           TextEditingController(text: updatedTime);
  //       TextEditingController amountController =
  //           TextEditingController(text: updatedAmount);
  //       return Padding(
  //         padding:
  //             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
  //         child: StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState) {
  //             return Container(
  //               height: 300,
  //               padding: const EdgeInsets.all(16.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 children: [
  //                   const Text(
  //                     'Edit Record',
  //                     style: TextStyle(
  //                       fontSize: 20.0,
  //                       fontWeight: FontWeight.bold,
  //                       color: Color.fromARGB(255, 7, 107, 132),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 16.0),
  //                   TextField(
  //                     decoration: const InputDecoration(
  //                       labelText: 'Time',
  //                       hintText: 'Enter new time',
  //                     ),
  //                     onChanged: (value) {
  //                       setState(() {
  //                         updatedTime = value;
  //                         userDataProvider.items.value[index].time = value;
  //                       });
  //                     },
  //                     controller: timeController,
  //                   ),
  //                   const SizedBox(height: 16.0),
  //                   TextField(
  //                     decoration: const InputDecoration(
  //                       labelText: 'Amount of Water',
  //                       hintText: 'Enter new amount',
  //                     ),
  //                     onChanged: (value) {
  //                       setState(() {
  //                         updatedAmount = value;
  //                         userDataProvider.items.value[index].amountOfWater =
  //                             value;
  //                         // userDataProvider.amount += int.parse(value);
  //                         print(value);
  //                       });
  //                     },
  //                     controller: amountController,
  //                   ),
  //                   const SizedBox(height: 16.0),
  //                   ElevatedButton(
  //                     style: ElevatedButton.styleFrom(
  //                       shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(7)),
  //                       backgroundColor: const Color.fromARGB(255, 7, 107, 132),
  //                     ),
  //                     child: const Text('Save'),
  //                     onPressed: () {
  //                       userDataProvider.items.notifyListeners();
  //                       Navigator.pop(context);
  //                       setData();
  //                     },
  //                   )
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserDataProvider>(
        builder: (context, userDataModel, child) => StreamBuilder<
                DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user?.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final userData = snapshot.data?.data() as Map<String, dynamic>?;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 120, left: 33, right: 33, bottom: 5),
                      child: SizedBox(
                        width: 295,
                        height: 238,
                        child: Card(
                          color: const Color.fromRGBO(0, 200, 250, 0.415),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
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
                                  '${userDataModel.amount.round()} / ${(userData?['unit'] == 'pounds') ? (userData?['weight'] * 0.5).round().toString() : (userData?['weight'] * 30).round().toString()} ${(userData?['unit'] == 'kilograms' ? 'ml' : 'fl oz')}',
                                  style: const TextStyle(
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
                                      // changeUnit(),
                                      (userData?['unit'] == 'kilograms'
                                          ? '175 ml'
                                          : '6 fl oz'),
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    leading: const Icon(
                                      Icons.coffee_sharp,
                                      size: 70,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        userData?['unit'] == 'kilograms'
                                            ? userDataModel.amount += 175
                                            : userDataModel.amount += 6;
                                        print(userDataModel.amount);
                                        userDataModel.items.value
                                            .add(DrinkRecordModel(
                                          time: TimeOfDay.now().format(context),
                                          amountOfWater:
                                              (userData?['unit'] == 'kilograms'
                                                  ? '175 ml'
                                                  : '6 fl oz'),
                                        ));
                                      });
                                      setData();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5, left: 173, right: 173),
                      child: Icon(
                        Icons.arrow_upward,
                        color: Color.fromARGB(255, 7, 107, 132),
                      ),
                    ),
                    const ResponsiveContainer(
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: 5, left: 10, right: 10),
                        child: Text(
                          'Click here to confirm that you drank water',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(146, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
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
                            color: const Color.fromARGB(255, 220, 239, 249),
                            shadowColor: const Color.fromARGB(14, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child:
                                ValueListenableBuilder<List<DrinkRecordModel>>(
                              valueListenable: userDataModel.items,
                              builder: (context, items, child) {
                                return ListView.builder(
                                  padding: const EdgeInsets.only(top: 15),
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    return DrinkRecord(
                                      time: items[index].time,
                                      amountOfWater: items[index].amountOfWater,
                                      onDelete: () {
                                        _deleteItem(index, userData?['unit']);
                                      },
                                      // onEdit: () {
                                      //   // _editItem(index);
                                      // },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: _bannerAd?.size.width.toDouble(),
                      height: _bannerAd?.size.height.toDouble(),
                      child: _bannerAd == null
                          // Nothing to render yet.
                          ? const SizedBox()
                          // The actual ad.
                          : AdWidget(ad: _bannerAd!),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
