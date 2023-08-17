import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/repositories/wishlist_repository.dart';

class GetWishlistByProductId {
  final WishlistRepository repository;

  GetWishlistByProductId(this.repository);

  Future<Either<Failure, bool>> execute({
    required String token,
    required int userId,
    required int productId,
  }) async {
    return await repository.getWishlistByProductId(
      token: token,
      userId: userId,
      productId: productId,
    );
  }
}
