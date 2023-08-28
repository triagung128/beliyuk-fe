import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:beliyuk/common/constants.dart';
import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/data/models/courier_model.dart';
import 'package:beliyuk/data/models/responses/courier_list_response_model.dart';

abstract class CourierRemoteDataSource {
  Future<CourierModel> getCourier({
    required String destination,
    required int weight,
  });
}

class CourierRemoteDataSourceImpl implements CourierRemoteDataSource {
  final http.Client client;

  CourierRemoteDataSourceImpl({required this.client});

  @override
  Future<CourierModel> getCourier({
    required String destination,
    required int weight,
  }) async {
    final response = await client.post(
      Uri.parse(Urls.getAllCourier),
      headers: {
        'key': Urls.apiKeyRajaOngkir,
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'origin': '154',
        'destination': destination,
        'weight': weight,
        'courier': 'jne',
      }),
    );

    if (response.statusCode == 200) {
      return CourierListResponseModel.fromJson(json.decode(response.body))
          .results
          .first;
    } else {
      throw ServerException();
    }
  }
}
