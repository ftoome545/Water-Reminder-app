import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder_app/screens/home_page.dart';
import 'package:water_reminder_app/screens/start_page.dart';
import 'package:water_reminder_app/services/notify_service.dart';
import 'package:water_reminder_app/widgets/database.dart';
import 'package:water_reminder_app/widgets/user_data.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model/pages_names.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());

  await NotificationServices().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
        create: (context) => CloudDataProvider(), child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? profileImagePath;
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final cloudDataProvider =
        Provider.of<CloudDataProvider>(context, listen: false);
    final weight = cloudDataProvider.weight;
    final unit = cloudDataProvider.unit;
    final bedtime = cloudDataProvider.bedtime;
    final wakeUpTime = cloudDataProvider.wakeUptime;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CloudDataProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: user == null
            ? const StartPage()
            : HomePage(
                weight: weight ?? 0,
                unit: unit ?? '',
                bedTime: bedtime ?? '',
                wakeUpTime: wakeUpTime ?? ''),
        onGenerateRoute: MyRoutes.genrateRoute,
      ),
    );
  }
}
