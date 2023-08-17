import 'package:beliyuk/domain/entities/user.dart';
import 'package:beliyuk/domain/repositories/auth_repository.dart';

class GetAuth {
  final AuthRepository repository;

  GetAuth(this.repository);

  Future<User?> execute() async {
    return await repository.getAuth();
  }
}
