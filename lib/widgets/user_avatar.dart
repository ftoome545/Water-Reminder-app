import 'package:shared_preferences/shared_preferences.dart';

// Save user's avatar
Future<void> saveUserAvatar(String userID, String avatarPath) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String key = "avatar_$userID";
  await prefs.setString(key, avatarPath);
}

// Retrieve user's avatar
Future<String> getUserAvatar(String userID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String key = "avatar_$userID";
  String? avatarPath = prefs.getString(key);
  return avatarPath!;
}
