import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/transaction.dart';
import 'package:beliyuk/domain/repositories/transaction_repository.dart';

class GetAllTransactions {
  final TransactionRepository repository;

  GetAllTransactions(this.repository);

  Future<Either<Failure, List<Transaction>>> execute({
    required int userId,
    required String token,
  }) async {
    return await repository.getAllTransactions(userId: userId, token: token);
  }
}
