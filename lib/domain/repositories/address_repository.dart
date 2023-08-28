import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/address.dart';

abstract class AddressRepository {
  Future<Either<Failure, List<Province>>> getAllProvinces();

  Future<Either<Failure, List<City>>> getAllCities(String provinceId);
}
