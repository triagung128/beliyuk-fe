import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:beliyuk/common/global_variables.dart';
import 'package:beliyuk/data/models/requests/login_request_model.dart';
import 'package:beliyuk/data/models/requests/register_request_model.dart';
import 'package:beliyuk/data/models/responses/auth_response_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel request,
  ) async {
    final response = await http.post(
      Uri.parse('${GlobalVariables.baseUrl}/api/auth/local'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(json.decode(response.body)));
    } else if (response.statusCode == 400) {
      return const Left('Username dan password salah');
    } else {
      return const Left('Gagal login');
    }
  }

  Future<Either<String, AuthResponseModel>> register(
    RegisterRequestModel request,
  ) async {
    final response = await http.post(
      Uri.parse('${GlobalVariables.baseUrl}/api/auth/local/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(json.decode(response.body)));
    } else if (response.statusCode == 400) {
      return const Left('Email sudah pernah digunakan');
    } else {
      return const Left('Gagal register');
    }
  }
}
