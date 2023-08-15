import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic6_fe_beliyuk/data/models/responses/item_product_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:fic6_fe_beliyuk/common/global_variables.dart';
import 'package:fic6_fe_beliyuk/data/models/responses/list_product_response_model.dart';

class ProductRemoteDatasource {
  Future<Either<String, ListProductResponseModel>> getAllProduct() async {
    final response =
        await http.get(Uri.parse(dotenv.env['GET_ALL_PRODUCT_URL']!));

    if (response.statusCode == 200) {
      return Right(
          ListProductResponseModel.fromJson(json.decode(response.body)));
    } else {
      return const Left('Data produk gagal dimuat !');
    }
  }

  Future<Either<String, ItemProductResponseModel>> getProductById(
    int id,
  ) async {
    final response = await http.get(Uri.parse(
        '${GlobalVariables.baseUrl}/api/products/$id?populate[category][populate]=*&populate[images]=*'));

    if (response.statusCode == 200) {
      return Right(
          ItemProductResponseModel.fromJson(json.decode(response.body)));
    } else {
      return const Left('Data produk gagal dimuat !');
    }
  }

  Future<Either<String, ListProductResponseModel>> searchProduct(
    String name,
  ) async {
    final response = await http.get(Uri.parse(
        '${GlobalVariables.baseUrl}/api/products?filters[name][\$contains]=$name&populate[category][populate]=*&populate[images]=*'));

    if (response.statusCode == 200) {
      return Right(
          ListProductResponseModel.fromJson(json.decode(response.body)));
    } else {
      return const Left('Data produk gagal dimuat !');
    }
  }

  Future<Either<String, ListProductResponseModel>> getProductsByCategoryId(
    int id,
  ) async {
    final response = await http.get(Uri.parse(
        '${GlobalVariables.baseUrl}/api/products?filters[category][id][\$eq]=$id&populate[category][populate]=*&populate[images]=*'));

    if (response.statusCode == 200) {
      return Right(
          ListProductResponseModel.fromJson(json.decode(response.body)));
    } else {
      return const Left('Data produk gagal dimuat !');
    }
  }
}
