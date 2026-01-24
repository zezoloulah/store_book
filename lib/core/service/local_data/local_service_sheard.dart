import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  static late SharedPreferences _preferences;
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token ,String email) async {
    await _preferences.setString('token', token);
    await _preferences.setString('email', email);
  }

  static String? get token => _preferences.getString('token');
  
  static String? get email => _preferences.getString('email');
  static Future<void> clear() async {
    await _preferences.clear();
  }
}
