import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences? preferences;

  LocalStorage() {
    createPrefInstance();
  }
  void createPrefInstance() async {
    preferences = await SharedPreferences.getInstance();
  }

  void setToken(String? token) async {
    await preferences?.setString('x-auth-token', token ?? '');
  }

  Future<String?> getToken() async {
    return preferences?.getString('x-auth-token');
  }

  void setGoogleToken(String? token) async {
    await preferences?.setString('google-token', token ?? '');
  }

  Future<String?> getGoogleToken() async {
    return preferences?.getString('google-token');
  }
}
