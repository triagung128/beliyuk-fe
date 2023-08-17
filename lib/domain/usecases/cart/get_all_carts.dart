import 'package:beliyuk/domain/entities/cart.dart';
import 'package:beliyuk/domain/repositories/cart_repository.dart';

class GetAllCarts {
  final CartRepository repository;

  GetAllCarts(this.repository);

  Future<List<Cart>> execute() async {
    return await repository.getAllCarts();
  }
}
