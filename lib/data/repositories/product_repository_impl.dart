import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/data/datasources/remote/product_remote_data_source.dart';
import 'package:beliyuk/domain/entities/product.dart';
import 'package:beliyuk/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final result = await remoteDataSource.getAllProducts();
      return Right(
        List<Product>.from(result.map((product) => product.toEntity())),
      );
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProductsByCategory(
    int categoryId,
  ) async {
    try {
      final result =
          await remoteDataSource.getAllProductsByCategory(categoryId);
      return Right(
        List<Product>.from(result.map((product) => product.toEntity())),
      );
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int productId) async {
    try {
      final result = await remoteDataSource.getProductById(productId);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    try {
      final result = await remoteDataSource.searchProducts(query);
      return Right(
        List<Product>.from(result.map((product) => product.toEntity())),
      );
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }
}
