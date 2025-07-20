import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telemedicine_platform_for_remote_areas/features/auth/data/models/auth_user_model.dart';

class AuthController {
  final String _tokenKey = 'token';
  final String _userDataKey = 'user-data';

  String? token;
  AuthUserModel? user;

  Future<void> saveUserData(String accessToken, AuthUserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, accessToken);
    await sharedPreferences.setString(_userDataKey, jsonEncode(userModel.toJson()));

    token = accessToken;
    user = userModel;
  }

  Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(_tokenKey);
    String? userData = sharedPreferences.getString(_userDataKey);
    if (userData != null) {
      user = AuthUserModel.fromJson(jsonDecode(userData));
    }
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString(_tokenKey);
    if (accessToken != null) {
      await getUserData();
      return true;
    }
    return false;
  }
  

  Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
    user = null;
  }

  bool isValidUser() {
    return token != null;
  }
}


