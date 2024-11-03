import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/strings.dart';

class CacheData {
  static Future<void> cacheToken(
      {required String token, required SharedPreferences pref}) async {
    await pref.setString(Strings.tokenKey, token);
  }

  static String? getToken({required SharedPreferences pref}) {
    String? token = pref.getString(Strings.tokenKey);
    return token;
  }

  // clear prefs data
  static Future<void> clearData() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(Strings.tokenKey);
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
