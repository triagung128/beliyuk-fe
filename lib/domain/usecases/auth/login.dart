import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/user.dart';
import 'package:beliyuk/domain/repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<Either<Failure, User>> execute({
    required String identifier,
    required String password,
  }) async {
    return await repository.login(identifier: identifier, password: password);
  }
}
