import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/courier.dart';

abstract class CourierRepository {
  Future<Either<Failure, Courier>> getCost({
    required String destination,
    required int weight,
  });
}
