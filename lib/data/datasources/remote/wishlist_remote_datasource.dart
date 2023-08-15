import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:fic6_fe_beliyuk/common/global_variables.dart';
import 'package:fic6_fe_beliyuk/data/datasources/local/auth_local_datasource.dart';
import 'package:fic6_fe_beliyuk/data/models/requests/wishlist_request_model.dart';
import 'package:fic6_fe_beliyuk/data/models/responses/list_wishlist_response_model.dart';
import 'package:fic6_fe_beliyuk/data/models/wishlist_model.dart';

class WishlistRemoteDatasource {
  final AuthLocalDatasource _authLocalDatasource;

  WishlistRemoteDatasource(this._authLocalDatasource);

  Future<Either<String, ListWishlistResponseModel>> getAllWhislist() async {
    final auth = await _authLocalDatasource.getAuth();

    if (auth != null) {
      final userId = auth.user.id;
      final token = auth.jwt;

      final response = await http.get(
        Uri.parse(
            '${GlobalVariables.baseUrl}/api/wishlists?filters[userId][\$eq]=$userId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return Right(
            ListWishlistResponseModel.fromJson(json.decode(response.body)));
      } else {
        return const Left('Gagal memuat data whislist!');
      }
    } else {
      return const Left('Anda belum login !');
    }
  }

  Future<WishlistModel?> getWishlistByProductId(int productId) async {
    final auth = await _authLocalDatasource.getAuth();

    if (auth != null) {
      final userId = auth.user.id;
      final token = auth.jwt;

      final response = await http.get(
        Uri.parse(
            '${GlobalVariables.baseUrl}/api/wishlists?filters[userId][\$eq]=$userId&filters[productId][\$eq]=$productId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data =
            ListWishlistResponseModel.fromJson(json.decode(response.body)).data;

        if (data.isNotEmpty && data.length == 1) return data.first;
      }
    }

    return null;
  }

  Future<Either<String, String>> addWishlist(
    WishlistRequestModel request,
  ) async {
    final auth = await _authLocalDatasource.getAuth();

    if (auth != null) {
      final token = auth.jwt;
      final userId = auth.user.id;

      final requestData = request.copyWith(userId: userId);

      final response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/api/wishlists'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestData.toJson()),
      );

      if (response.statusCode == 200) {
        return const Right('Berhasil menambahkan wishlist');
      } else {
        return const Left('Gagal menambahkan wishlist !');
      }
    } else {
      return const Left('Anda belum login !');
    }
  }

  Future<Either<String, String>> removeWishlist(int productId) async {
    final auth = await _authLocalDatasource.getAuth();

    if (auth != null) {
      final userId = auth.user.id;
      final token = auth.jwt;

      final getWhislistResponse = await http.get(
        Uri.parse(
            '${GlobalVariables.baseUrl}/api/wishlists?filters[userId][\$eq]=$userId&filters[productId][\$eq]=$productId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (getWhislistResponse.statusCode == 200) {
        final data = ListWishlistResponseModel.fromJson(
                json.decode(getWhislistResponse.body))
            .data;

        if (data.isNotEmpty && data.length == 1) {
          final whislistId = data.first.id;

          final removeWhislistResponse = await http.delete(
            Uri.parse('${GlobalVariables.baseUrl}/api/wishlists/$whislistId'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          );

          if (removeWhislistResponse.statusCode == 200) {
            return const Right('Berhasil menghapus wishlist');
          }
        }
      }

      return const Left('Gagal menghapus wishlist !');
    } else {
      return const Left('Anda belum login !');
    }
  }
}
