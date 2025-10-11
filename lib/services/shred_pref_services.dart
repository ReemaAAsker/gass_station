import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? _prefs;

  // ✅ Initialize once (call it in main or splash)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ✅ Save login credentials
  static Future<void> saveLogin({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    if (_prefs == null) await init();

    if (rememberMe) {
      await _prefs!.setString('email', email);
      await _prefs!.setString('password', password);
      await _prefs!.setBool('rememberMe', true);
    } else {
      await logout();
    }
  }

  // ✅ Get saved email
  static String? getEmail() => _prefs?.getString('email');

  // ✅ Get saved password
  static String? getPassword() => _prefs?.getString('password');

  // ✅ Check remember status
  static bool getRememberMe() => _prefs?.getBool('rememberMe') ?? false;

  // ✅ Clear all login data
  static Future<void> logout() async {
    if (_prefs == null) await init();
    await _prefs!.remove('email');
    await _prefs!.remove('password');
    await _prefs!.setBool('rememberMe', false);
  }

  static void clr() {
    _prefs?.clear();
  }
}
