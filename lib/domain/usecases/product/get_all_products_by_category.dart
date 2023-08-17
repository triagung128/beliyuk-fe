import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/product.dart';
import 'package:beliyuk/domain/repositories/product_repository.dart';

class GetAllProductsByCategory {
  final ProductRepository repository;

  GetAllProductsByCategory(this.repository);

  Future<Either<Failure, List<Product>>> execute(int categoryId) async {
    return await repository.getAllProductsByCategory(categoryId);
  }
}
