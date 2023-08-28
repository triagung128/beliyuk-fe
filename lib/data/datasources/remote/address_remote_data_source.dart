import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:beliyuk/common/constants.dart';
import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/data/models/city_model.dart';
import 'package:beliyuk/data/models/responses/city_list_response_model.dart';

abstract class AddressRemoteDataSource {
  Future<List<CityModel>> getAllCities(String provinceId);
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final http.Client client;

  AddressRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CityModel>> getAllCities(String provinceId) async {
    final response = await client.get(
      Uri.parse(Urls.getAllCities(provinceId)),
      headers: {
        'key': Urls.apiKeyRajaOngkir,
      },
    );

    if (response.statusCode == 200) {
      return CityListResponseModel.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }
}
