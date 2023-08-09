import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic6_fe_beliyuk/data/models/responses/list_category_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CategoryRemoteDatasource {
  Future<Either<String, ListCategoryResponseModel>> getAllCategory() async {
    final response =
        await http.get(Uri.parse(dotenv.env['GET_ALL_CATEGORY_URL']!));

    if (response.statusCode == 200) {
      return Right(
          ListCategoryResponseModel.fromJson(json.decode(response.body)));
    } else {
      return const Left('Data kategori gagal dimuat !');
    }
  }
}
