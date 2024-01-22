import 'package:flutter/material.dart';
import 'package:water_reminder_app/screens/add_user_info.dart';
import 'package:water_reminder_app/screens/home_page.dart';
// import 'package:water_reminder_app/screens/home.dart';
import 'package:water_reminder_app/screens/login_page.dart';
import 'package:water_reminder_app/screens/privacy_policy.dart';
import 'package:water_reminder_app/screens/reminder_schedule.dart';
import 'package:water_reminder_app/screens/reset_password.dart';
// import 'package:water_reminder_app/screens/profile_page.dart';
import 'package:water_reminder_app/screens/signUp_page.dart';
import 'package:water_reminder_app/screens/start_page.dart';
import 'package:water_reminder_app/screens/verification_page.dart';

// import '../screens/home.dart';
import '../screens/profile_page.dart';
import '../screens/user_info.dart';

class MyRoutes {
  static Route<dynamic> genrateRoute(RouteSettings setting) {
    switch (setting.name) {
      case startPage:
        return MaterialPageRoute(builder: (context) => const StartPage());
      case logInPage:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case signUpPage:
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case userDataPage:
        return MaterialPageRoute(builder: (context) => const UserInfoPage());
      case addUserDataPage:
        return MaterialPageRoute(builder: (context) => const AddUserInfo());
      case profilePage:
        return MaterialPageRoute(builder: (context) => const ProfilePage());
      case homePage:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case resetPasswordPage:
        return MaterialPageRoute(builder: (context) => const ResetPassword());
      case verificationPage:
        return MaterialPageRoute(
            builder: (context) => const VerificationPage());
      case reminderSchedulePage:
        return MaterialPageRoute(
            builder: (context) => const ReminderSchedule());
      case privacyPolicyPage:
        return MaterialPageRoute(builder: (context) => const PrivacyPolicy());
      default:
    }

    return MaterialPageRoute(
        builder: (context) => const Scaffold(
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
const String reminderSchedulePage = '/reminderSchedulePage';
const String privacyPolicyPage = '/privacyPolicyPage';
