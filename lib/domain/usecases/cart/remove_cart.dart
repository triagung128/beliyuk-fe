import 'package:beliyuk/domain/repositories/cart_repository.dart';

class RemoveCart {
  final CartRepository repository;

  RemoveCart(this.repository);

  Future<String> execute(int id) async {
    return await repository.removeCart(id);
  }
}
