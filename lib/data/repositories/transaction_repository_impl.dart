import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/data/datasources/remote/transaction_remote_data_source.dart';
import 'package:beliyuk/data/models/transaction_model.dart';
import 'package:beliyuk/domain/entities/midtrans.dart';
import 'package:beliyuk/domain/entities/transaction.dart';
import 'package:beliyuk/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Midtrans>> createTransaction({
    required Transaction data,
    required String token,
  }) async {
    try {
      final result = await remoteDataSource.createTransaction(
        data: TransactionModel.fromEntity(data),
        token: token,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Koneksi Terputus'));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getAllTransactions({
    required int userId,
    required String token,
  }) async {
    try {
      final result = await remoteDataSource.getAllTransactions(
        userId: userId,
        token: token,
      );
      return Right(
        List<Transaction>.from(result.map((item) => item.toEntity())),
      );
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Koneksi Terputus'));
    }
  }
}
