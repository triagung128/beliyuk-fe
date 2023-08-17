import 'package:beliyuk/domain/entities/user.dart';
import 'package:beliyuk/domain/repositories/auth_repository.dart';

class SaveAuth {
  final AuthRepository repository;

  SaveAuth(this.repository);

  Future<String> execute(User data) async {
    return await repository.saveAuth(data);
  }
}
