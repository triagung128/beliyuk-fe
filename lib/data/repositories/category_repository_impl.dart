import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/data/datasources/remote/category_remote_data_source.dart';
import 'package:beliyuk/domain/entities/category.dart';
import 'package:beliyuk/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final result = await remoteDataSource.getAllCategories();
      return Right(List<Category>.from(result.map((item) => item.toEntity())));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }
}
