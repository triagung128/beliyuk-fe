import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:beliyuk/common/constants.dart';
import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/data/models/category_model.dart';
import 'package:beliyuk/data/models/responses/category_list_response_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getAllCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final http.Client client;

  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final response = await client.get(Uri.parse(Urls.getAllCategories));

    if (response.statusCode == 200) {
      return CategoryListResponseModel.fromJson(json.decode(response.body))
          .categories;
    } else {
      throw ServerException();
    }
  }
}
