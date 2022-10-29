import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences? preferences;

  LocalStorage() {}
  void createPrefInstance() async {
    preferences = await SharedPreferences.getInstance();
  }

  void setToken(String? token) async {
    preferences = await SharedPreferences.getInstance();

    var chk = await preferences?.setString('x-auth-token', token ?? '');
    debugPrint('setting token:' + chk.toString());
  }

  Future<String?> getToken() async {
    preferences = await SharedPreferences.getInstance();

    var chk = preferences?.getString('x-auth-token');
    debugPrint('setting token:' + chk.toString());
    return chk;
  }

  void setGoogleToken(String? token) async {
    preferences = await SharedPreferences.getInstance();

    await preferences?.setString('google-token', token ?? '');
  }

  Future<String?> getGoogleToken() async {
    preferences = await SharedPreferences.getInstance();

    return preferences?.getString('google-token');
  }
}
