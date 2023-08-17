import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/wishlist.dart';
import 'package:beliyuk/domain/repositories/wishlist_repository.dart';

class GetAllWishlists {
  final WishlistRepository repository;

  GetAllWishlists(this.repository);

  Future<Either<Failure, List<Wishlist>>> execute({
    required String token,
    required int userId,
  }) async {
    return await repository.getAllWishlists(token: token, userId: userId);
  }
}
