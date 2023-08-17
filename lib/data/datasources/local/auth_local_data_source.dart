import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:beliyuk/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<bool> saveAuth(UserModel data);
  Future<bool> removeAuth();
  Future<UserModel?> getAuth();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const _authKey = 'auth';

  @override
  Future<bool> saveAuth(UserModel data) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_authKey, json.encode(data.toJson()));
  }

  @override
  Future<bool> removeAuth() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_authKey);
  }

  @override
  Future<UserModel?> getAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authJson = prefs.getString(_authKey);
    if (authJson != null) return UserModel.fromJson(json.decode(authJson));
    return null;
  }
}
