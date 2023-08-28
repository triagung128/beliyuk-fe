import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/address.dart';
import 'package:beliyuk/domain/repositories/address_repository.dart';

class GetAllCities {
  final AddressRepository repository;

  GetAllCities(this.repository);

  Future<Either<Failure, List<City>>> execute(String provinceId) async {
    return await repository.getAllCities(provinceId);
  }
}
