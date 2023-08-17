import 'package:beliyuk/domain/entities/cart.dart';
import 'package:beliyuk/domain/repositories/cart_repository.dart';

class AddCart {
  final CartRepository repository;

  AddCart(this.repository);

  Future<String> execute(Cart data) async {
    return await repository.addCart(data);
  }
}
