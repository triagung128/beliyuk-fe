import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/midtrans.dart';
import 'package:beliyuk/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<Either<Failure, Midtrans>> createTransaction({
    required Transaction data,
    required String token,
  });
  Future<Either<Failure, List<Transaction>>> getAllTransactions({
    required int userId,
    required String token,
  });
}
