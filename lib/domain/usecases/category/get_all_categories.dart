import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/category.dart';
import 'package:beliyuk/domain/repositories/category_repository.dart';

class GetAllCategories {
  final CategoryRepository repository;

  GetAllCategories(this.repository);

  Future<Either<Failure, List<Category>>> execute() async {
    return await repository.getAllCategories();
  }
}
