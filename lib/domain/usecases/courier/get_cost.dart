import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/courier.dart';
import 'package:beliyuk/domain/repositories/courier_repository.dart';

class GetCost {
  final CourierRepository repository;

  GetCost(this.repository);

  Future<Either<Failure, Courier>> execute({
    required String destination,
    required int weight,
  }) async {
    return await repository.getCost(
      destination: destination,
      weight: weight,
    );
  }
}
