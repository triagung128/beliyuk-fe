import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/product.dart';
import 'package:beliyuk/domain/repositories/product_repository.dart';

class SearchProducts {
  final ProductRepository repository;

  SearchProducts(this.repository);

  Future<Either<Failure, List<Product>>> execute(String query) async {
    return await repository.searchProducts(query);
  }
}
