import 'package:beliyuk/domain/entities/cart.dart';
import 'package:beliyuk/domain/repositories/cart_repository.dart';

class ReduceQuantity {
  final CartRepository repository;

  ReduceQuantity(this.repository);

  Future<void> execute(Cart data) async {
    return await repository.reduceQuantity(data);
  }
}
