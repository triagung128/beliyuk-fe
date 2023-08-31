import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/midtrans.dart';
import 'package:beliyuk/domain/entities/transaction.dart';
import 'package:beliyuk/domain/repositories/transaction_repository.dart';

class CreateTransaction {
  final TransactionRepository repository;

  CreateTransaction(this.repository);

  Future<Either<Failure, Midtrans>> execute({
    required Transaction data,
    required String token,
  }) async {
    return await repository.createTransaction(data: data, token: token);
  }
}
