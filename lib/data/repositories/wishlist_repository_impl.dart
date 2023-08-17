import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/data/datasources/remote/wishlist_remote_data_source.dart';
import 'package:beliyuk/data/models/wishlist_model.dart';
import 'package:beliyuk/domain/entities/wishlist.dart';
import 'package:beliyuk/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;

  WishlistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> addWishlist({
    required String token,
    required int userId,
    required Wishlist data,
  }) async {
    try {
      final result = await remoteDataSource.addWishlist(
        token: token,
        userId: userId,
        data: WishlistModel.fromEntity(data),
      );
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, List<Wishlist>>> getAllWishlists({
    required String token,
    required int userId,
  }) async {
    try {
      final result = await remoteDataSource.getAllWishlists(
        token: token,
        userId: userId,
      );
      return Right(List<Wishlist>.from(result.map((item) => item.toEntity())));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, bool>> getWishlistByProductId({
    required String token,
    required int userId,
    required int productId,
  }) async {
    try {
      final result = await remoteDataSource.getWishlistByProductId(
        token: token,
        userId: userId,
        productId: productId,
      );
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, String>> removeWishlist({
    required String token,
    required int userId,
    required int productId,
  }) async {
    try {
      final result = await remoteDataSource.removeWishlist(
        token: token,
        userId: userId,
        productId: productId,
      );
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }
}
