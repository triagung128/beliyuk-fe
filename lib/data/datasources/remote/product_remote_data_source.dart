import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:beliyuk/common/constants.dart';
import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/data/models/product_model.dart';
import 'package:beliyuk/data/models/responses/product_list_response_model.dart';
import 'package:beliyuk/data/models/responses/product_response_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(int productId);
  Future<List<ProductModel>> searchProducts(String query);
  Future<List<ProductModel>> getAllProductsByCategory(int categoryId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await client.get(Uri.parse(Urls.getAllProducts));

    if (response.statusCode == 200) {
      return ProductListResponseModel.fromJson(json.decode(response.body))
          .products;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProductById(int productId) async {
    final response =
        await client.get(Uri.parse(Urls.getProductById(productId)));

    if (response.statusCode == 200) {
      return ProductResponseModel.fromJson(json.decode(response.body)).product;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    final response = await client.get(Uri.parse(Urls.searchProducts(query)));

    if (response.statusCode == 200) {
      return ProductListResponseModel.fromJson(json.decode(response.body))
          .products;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getAllProductsByCategory(int categoryId) async {
    final response =
        await client.get(Uri.parse(Urls.getAllProductsByCategory(categoryId)));

    if (response.statusCode == 200) {
      return ProductListResponseModel.fromJson(json.decode(response.body))
          .products;
    } else {
      throw ServerException();
    }
  }
}
