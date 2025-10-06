import 'dart:convert';
import 'package:ocad/src/database/apis/api_calls.dart';
import 'package:ocad/src/models/user_model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final ApiCalls apiCalls = ApiCalls();
  static const _userKey = 'user';
  static const _sessionToken = 'accessToken';
  // static const _refreshTokenKey = 'refreshToken';
  static const _sessionTokenExpiryKey = 'tokenExpiry';

  // 🧩 Save user session
  Future<void> saveUserSession(UserModel user, String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_userKey, jsonEncode(user.toJson()));
    await prefs.setString(_sessionToken, token);
    // await prefs.setString(_refreshTokenKey, user.);
    await prefs.setString(
      _sessionTokenExpiryKey,
      DateTime.now().add(const Duration(days: 2)).toIso8601String(),
    );
  }

  // 🔑 Get session token
  Future<String?> getSessionToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_sessionToken);
  }

  // 🔁 Get refresh token
  // Future<String?> getRefreshToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_refreshTokenKey);
  // }

  // 👤 Get user data
  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson == null) return null;
    return UserModel.fromJson(jsonDecode(userJson));
  }

  // 🕒 Check if session valid
  Future<bool> isSessionValid() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryStr = prefs.getString(_sessionTokenExpiryKey);
    if (expiryStr == null) return false;

    final expiryDate = DateTime.parse(expiryStr);
    try {
      final tokenValue = await getSessionToken();
      if (tokenValue != null) {
        final isValid = await apiCalls.validateToken(tokenValue);
        if (isValid.toLowerCase() == 'ok') {
          return DateTime.now().isBefore(expiryDate);
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }

    return DateTime.now().isBefore(expiryDate);
  }

  // 🚪 Clear session
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_sessionToken);
    // await prefs.remove(_refreshTokenKey);
    await prefs.remove(_sessionTokenExpiryKey);
  }
}
