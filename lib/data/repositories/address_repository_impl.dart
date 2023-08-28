import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/data/datasources/local/address_local_data_source.dart';
import 'package:beliyuk/data/datasources/remote/address_remote_data_source.dart';
import 'package:beliyuk/domain/entities/address.dart';
import 'package:beliyuk/domain/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressLocalDataSource localDataSource;
  final AddressRemoteDataSource remoteDataSource;

  AddressRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<City>>> getAllCities(String provinceId) async {
    try {
      final result = await remoteDataSource.getAllCities(provinceId);
      return Right(List<City>.from(result.map((item) => item.toEntity())));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, List<Province>>> getAllProvinces() async {
    try {
      final result = await localDataSource.getAllProvinces();
      return Right(List<Province>.from(result.map((item) => item.toEntity())));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
