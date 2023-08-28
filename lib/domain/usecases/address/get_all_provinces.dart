import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/address.dart';
import 'package:beliyuk/domain/repositories/address_repository.dart';

class GetAllProvinces {
  final AddressRepository repository;

  GetAllProvinces(this.repository);

  Future<Either<Failure, List<Province>>> execute() async {
    return await repository.getAllProvinces();
  }
}
