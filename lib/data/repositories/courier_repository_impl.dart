import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/data/datasources/remote/courier_remote_data_source.dart';
import 'package:beliyuk/domain/entities/courier.dart';
import 'package:beliyuk/domain/repositories/courier_repository.dart';

class CourierRepositoryImpl implements CourierRepository {
  final CourierRemoteDataSource remoteDataSource;

  CourierRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Courier>> getCost({
    required String destination,
    required int weight,
  }) async {
    try {
      final result = await remoteDataSource.getCourier(
        destination: destination,
        weight: weight,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }
}
