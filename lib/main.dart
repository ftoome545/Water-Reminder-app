import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_reminder_app/services/notify_service.dart';
import 'package:water_reminder_app/widgets/database.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model/pages_names.dart';

// void main() {
//   runApp(MaterialApp(home: const MyApp()));
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the FlutterLocalNotificationsPlugin
  await NotificationServices().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
    // debugShowCheckedModeBanner: false,
    // routes: {
    //   // '/': (context) => StartPage(),
    //   // Home.homePage:(context) => Hom(),
    // },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? profileImagePath;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserDataProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: startPage,
        // theme: ThemeData(primarySwatch: Colors.cyan),
        onGenerateRoute: MyRoutes.genrateRoute,
      ),
    );
  }
}
