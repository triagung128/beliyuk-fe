import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic6_fe_beliyuk/data/models/responses/list_banner_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BannerRemoteDatasource {
  Future<Either<String, ListBannerResponseModel>> getAllBanner() async {
    final response =
        await http.get(Uri.parse(dotenv.env['GET_ALL_BANNER_URL']!));

    if (response.statusCode == 200) {
      return Right(
          ListBannerResponseModel.fromJson(json.decode(response.body)));
    } else {
      return const Left('Gagal memuat data banner !');
    }
  }
}
