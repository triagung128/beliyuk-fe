import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:beliyuk/common/constants.dart';
import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String identifier,
    required String password,
  });

  Future<UserModel> register({
    required String username,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login({
    required String identifier,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse(Urls.login),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'identifier': identifier,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      throw AuthException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse(Urls.register),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      throw AuthException();
    } else {
      throw ServerException();
    }
  }
}
