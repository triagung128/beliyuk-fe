import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:fic6_fe_beliyuk/data/models/responses/auth_response_model.dart';

class AuthLocalDatasource {
  static const _authKey = 'auth';

  Future<bool> saveAuth(AuthResponseModel data) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_authKey, json.encode(data.toJson()));
  }

  Future<bool> removeAuth() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_authKey);
  }

  Future<AuthResponseModel?> getAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authJson = prefs.getString(_authKey);
    if (authJson != null) {
      return AuthResponseModel.fromJson(json.decode(authJson));
    } else {
      return null;
    }
  }
}
