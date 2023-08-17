import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String identifier,
    required String password,
  });

  Future<Either<Failure, User>> register({
    required String username,
    required String email,
    required String password,
  });

  Future<String> saveAuth(User data);

  Future<String> removeAuth();

  Future<User?> getAuth();
}
