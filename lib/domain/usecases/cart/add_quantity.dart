import 'package:beliyuk/domain/entities/cart.dart';
import 'package:beliyuk/domain/repositories/cart_repository.dart';

class AddQuantity {
  final CartRepository repository;

  AddQuantity(this.repository);

  Future<void> execute(Cart data) async {
    return await repository.addQuantity(data);
  }
}
