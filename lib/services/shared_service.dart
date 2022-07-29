import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_response.dart';



class SharedService {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('access');

    return token == null ? false : true;
  }

  static Future<User?> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');

    if (user != null) {
      return currentUser(user);
    }
    return null;
  }

  static Future<void> setUser(LoginResponse model) async {
    String user = json.encode(model.user);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access', model.access);
    await prefs.setString('refresh', model.refresh);
    await prefs.setString('user', user);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
