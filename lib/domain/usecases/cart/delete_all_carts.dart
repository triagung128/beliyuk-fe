import 'package:beliyuk/domain/repositories/cart_repository.dart';

class DeleteAllCarts {
  final CartRepository repository;

  DeleteAllCarts(this.repository);

  Future<void> execute() async {
    return repository.deleteAllCarts();
  }
}
