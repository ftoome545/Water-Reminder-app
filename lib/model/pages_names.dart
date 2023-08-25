import 'package:flutter/material.dart';
import 'package:water_reminder_app/screens/add_user_info.dart';
import 'package:water_reminder_app/screens/home_page.dart';
// import 'package:water_reminder_app/screens/home.dart';
import 'package:water_reminder_app/screens/login_page.dart';
import 'package:water_reminder_app/screens/new_password.dart';
import 'package:water_reminder_app/screens/reset_password.dart';
// import 'package:water_reminder_app/screens/profile_page.dart';
import 'package:water_reminder_app/screens/signUp_page.dart';
import 'package:water_reminder_app/screens/start_page.dart';
import 'package:water_reminder_app/screens/verification_page.dart';

// import '../screens/home.dart';
import '../screens/user_info.dart';

class MyRoutes {
  static Route<dynamic> genrateRoute(RouteSettings setting) {
    switch (setting.name) {
      case startPage:
        return MaterialPageRoute(builder: (context) => StartPage());
      case logInPage:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case signUpPage:
        return MaterialPageRoute(builder: (context) => SignUpPage());
      case userDataPage:
        return MaterialPageRoute(builder: (context) => UserInfoPage());
      case addUserDataPage:
        return MaterialPageRoute(builder: (context) => AddUserInfo());
      // case profilePage:
      //   var unit = setting.arguments as String;
      //   var weight = setting.arguments as double;
      //   var bedTime = setting.arguments as String;
      //   var wakeUpTime = setting.arguments as String;
      //   return MaterialPageRoute(
      //       builder: (context) => ProfilePage(
      //             userBedTime: bedTime,
      //             userWakeUpTime: wakeUpTime,
      //             userWeight: weight,
      //             weightUnit: unit,
      //           ));
      case homePage:
        var unit = setting.arguments as String;
        var weight = setting.arguments as double;
        var bedTime = setting.arguments as String;
        var wakeUpTime = setting.arguments as String;
        return MaterialPageRoute(
            builder: (context) => HomePage(
                  unit: unit,
                  wakeUpTime: wakeUpTime,
                  bedTime: bedTime,
                  weight: weight,
                ));
      case resetPasswordPage:
        return MaterialPageRoute(builder: (context) => ResetPassword());
      case verificationPage:
        return MaterialPageRoute(builder: (context) => VerificationPage());
      case newPasswordPage:
        return MaterialPageRoute(builder: (context) => NewPasswordPage());
      default:
    }

    return MaterialPageRoute(
        builder: (context) => Scaffold(
              body: Text('No page defined'),
            ));
  }
}

const String startPage = '/';
const String logInPage = '/logInPage';
const String signUpPage = '/signUpPage';
const String userDataPage = '/userData';
const String addUserDataPage = '/addUserData';
const String homePage = '/homePage';
const String profilePage = '/profilePage';
const String resetPasswordPage = '/resetPasswordPage';
const String verificationPage = '/verificationPage';
const String newPasswordPage = '/newPasswordPage';
