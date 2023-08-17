import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/wishlist.dart';
import 'package:beliyuk/domain/repositories/wishlist_repository.dart';

class AddWishlist {
  final WishlistRepository repository;

  AddWishlist(this.repository);

  Future<Either<Failure, String>> execute({
    required String token,
    required int userId,
    required Wishlist data,
  }) async {
    return await repository.addWishlist(
      token: token,
      userId: userId,
      data: data,
    );
  }
}
