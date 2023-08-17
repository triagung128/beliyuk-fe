import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
}
