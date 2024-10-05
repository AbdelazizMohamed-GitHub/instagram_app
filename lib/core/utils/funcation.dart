import 'package:shared_preferences/shared_preferences.dart';

Future<void> login() async {
  final prefs = await SharedPreferences.getInstance();
  // Set the login state
  await prefs.setBool('isLoggedIn', true);
}
Future<bool> checkLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  // Check if the user is logged in
  return prefs.getBool('isLoggedIn') ?? false;
}