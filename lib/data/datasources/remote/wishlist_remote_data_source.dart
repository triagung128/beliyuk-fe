import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:beliyuk/common/constants.dart';
import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/data/models/responses/wishlist_response_model.dart';
import 'package:beliyuk/data/models/wishlist_model.dart';

abstract class WishlistRemoteDataSource {
  Future<List<WishlistModel>> getAllWishlists({
    required String token,
    required int userId,
  });

  Future<bool> getWishlistByProductId({
    required String token,
    required int userId,
    required int productId,
  });

  Future<String> addWishlist({
    required String token,
    required int userId,
    required WishlistModel data,
  });

  Future<String> removeWishlist({
    required String token,
    required int userId,
    required int productId,
  });
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final http.Client client;

  WishlistRemoteDataSourceImpl({required this.client});

  @override
  Future<List<WishlistModel>> getAllWishlists({
    required String token,
    required int userId,
  }) async {
    final response = await client.get(
      Uri.parse(Urls.getAllWishlist(userId)),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return WishlistResponseModel.fromJson(json.decode(response.body))
          .wishlists;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> getWishlistByProductId({
    required String token,
    required int userId,
    required int productId,
  }) async {
    final response = await http.get(
      Uri.parse(Urls.getWishlistByProductId(userId, productId)),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data =
          WishlistResponseModel.fromJson(json.decode(response.body)).wishlists;

      if (data.isNotEmpty && data.length == 1) return true;
    }

    return false;
  }

  @override
  Future<String> addWishlist({
    required String token,
    required int userId,
    required WishlistModel data,
  }) async {
    final response = await http.post(
      Uri.parse(Urls.addWishlist),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data.toJson()),
    );

    if (response.statusCode == 200) {
      return 'Berhasil menambahkan wishlist';
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> removeWishlist({
    required String token,
    required int userId,
    required int productId,
  }) async {
    final getWhislistResponse = await http.get(
      Uri.parse(Urls.getWishlistByProductId(userId, productId)),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (getWhislistResponse.statusCode == 200) {
      final data =
          WishlistResponseModel.fromJson(json.decode(getWhislistResponse.body))
              .wishlists;

      if (data.isNotEmpty && data.length == 1) {
        final int wishlistId = data.first.id!;

        final removeWhislistResponse = await http.delete(
          Uri.parse(Urls.removeWishlist(wishlistId)),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (removeWhislistResponse.statusCode == 200) {
          return 'Berhasil menghapus wishlist';
        }
      }
    }

    throw ServerException();
  }
}
