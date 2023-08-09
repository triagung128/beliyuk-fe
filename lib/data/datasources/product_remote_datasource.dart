import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic6_fe_beliyuk/data/models/responses/list_product_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDatasource {
  Future<Either<String, ListProductResponseModel>> getAllProduct() async {
    final response =
        await http.get(Uri.parse(dotenv.env['GET_ALL_PRODUCT_URL']!));

    if (response.statusCode == 200) {
      return Right(
          ListProductResponseModel.fromJson(json.decode(response.body)));
    } else {
      return const Left('Data gagal dimuat!');
    }
  }
}
