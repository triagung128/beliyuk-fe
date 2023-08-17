import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/wishlist.dart';

abstract class WishlistRepository {
  Future<Either<Failure, List<Wishlist>>> getAllWishlists({
    required String token,
    required int userId,
  });

  Future<Either<Failure, bool>> getWishlistByProductId({
    required String token,
    required int userId,
    required int productId,
  });

  Future<Either<Failure, String>> addWishlist({
    required String token,
    required int userId,
    required Wishlist data,
  });

  Future<Either<Failure, String>> removeWishlist({
    required String token,
    required int userId,
    required int productId,
  });
}
