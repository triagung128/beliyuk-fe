import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/user.dart';
import 'package:beliyuk/domain/repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  Register(this.repository);

  Future<Either<Failure, User>> execute({
    required String username,
    required String email,
    required String password,
  }) async {
    return await repository.register(
      username: username,
      email: email,
      password: password,
    );
  }
}
