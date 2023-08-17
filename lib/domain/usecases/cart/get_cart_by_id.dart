import 'package:beliyuk/domain/entities/cart.dart';
import 'package:beliyuk/domain/repositories/cart_repository.dart';

class GetCartById {
  final CartRepository repository;

  GetCartById(this.repository);

  Future<Cart?> execute(int id) async {
    return await repository.getCartById(id);
  }
}
