import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  Future<void> saveRememberMe(bool rememberMe) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('remember_me', rememberMe);
    await prefs.setInt(
      'login_timestamp',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<bool> shouldStayLoggedIn() async {
    if (kIsWeb) return true;
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool('remember_me') ?? true;
    if (rememberMe) return true;

    final loginTimestamp = prefs.getInt('login_timestamp');
    if (loginTimestamp == null) return true;

    final daysSinceLogin = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(loginTimestamp))
        .inDays;
    return daysSinceLogin < 30;
  }
}
