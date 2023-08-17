import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/repositories/wishlist_repository.dart';

class RemoveWishlist {
  final WishlistRepository repository;

  RemoveWishlist(this.repository);

  Future<Either<Failure, String>> execute({
    required String token,
    required int userId,
    required int productId,
  }) async {
    return await repository.removeWishlist(
      token: token,
      userId: userId,
      productId: productId,
    );
  }
}
