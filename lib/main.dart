import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model/pages_names.dart';

// void main() {
//   runApp(MaterialApp(home: const MyApp()));
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MyApp(),
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: startPage,
      onGenerateRoute: MyRoutes.genrateRoute,
    );
  }
}
