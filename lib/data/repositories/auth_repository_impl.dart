import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/common/failure.dart';
import 'package:beliyuk/data/datasources/local/auth_local_data_source.dart';
import 'package:beliyuk/data/datasources/remote/auth_remote_data_source.dart';
import 'package:beliyuk/data/models/user_model.dart';
import 'package:beliyuk/domain/entities/user.dart';
import 'package:beliyuk/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<User?> getAuth() async {
    final result = await localDataSource.getAuth();
    if (result != null) return result.toEntity();
    return null;
  }

  @override
  Future<Either<Failure, User>> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(
        identifier: identifier,
        password: password,
      );
      return Right(result.toEntity());
    } on AuthException {
      return const Left(AuthFailure('Username dan password salah'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.register(
        username: username,
        email: email,
        password: password,
      );
      return Right(result.toEntity());
    } on AuthException {
      return const Left(AuthFailure('Email sudah pernah digunakan'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }

  @override
  Future<String> removeAuth() async {
    final result = await localDataSource.removeAuth();
    if (result) return 'Berhasil menghapus data auth';
    return 'Gagal menghapus data auth';
  }

  @override
  Future<String> saveAuth(User data) async {
    final result = await localDataSource.saveAuth(UserModel.fromEntity(data));
    if (result) return 'Berhasil menyimpan data auth';
    return 'Gagal menyimpan data auth';
  }
}
