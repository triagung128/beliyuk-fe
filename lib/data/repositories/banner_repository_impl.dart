import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/data/datasources/remote/banner_remote_data_source.dart';
import 'package:beliyuk/domain/entities/banner.dart';
import 'package:beliyuk/domain/repositories/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource remoteDataSource;

  BannerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Banner>>> getAllBanners() async {
    try {
      final result = await remoteDataSource.getAllBanners();
      return Right(List<Banner>.from(result.map((item) => item.toEntity())));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }
}
