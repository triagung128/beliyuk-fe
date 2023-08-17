import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:beliyuk/common/constants.dart';
import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/data/models/banner_model.dart';
import 'package:beliyuk/data/models/responses/banner_list_response_model.dart';

abstract class BannerRemoteDataSource {
  Future<List<BannerModel>> getAllBanners();
}

class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  final http.Client client;

  BannerRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BannerModel>> getAllBanners() async {
    final response = await client.get(Uri.parse(Urls.getAllBanners));

    if (response.statusCode == 200) {
      return ListBannerResponseModel.fromJson(json.decode(response.body))
          .banners;
    } else {
      throw ServerException();
    }
  }
}
