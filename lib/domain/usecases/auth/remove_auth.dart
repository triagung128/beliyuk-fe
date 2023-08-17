import 'package:beliyuk/domain/repositories/auth_repository.dart';

class RemoveAuth {
  final AuthRepository repository;

  RemoveAuth(this.repository);

  Future<String> execute() async {
    return await repository.removeAuth();
  }
}
