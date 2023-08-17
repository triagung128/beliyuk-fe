import 'package:beliyuk/domain/entities/cart.dart';

abstract class CartRepository {
  Future<List<Cart>> getAllCarts();
  Future<Cart?> getCartById(int id);
  Future<String> addCart(Cart data);
  Future<String> removeCart(int id);
  Future<void> addQuantity(Cart data);
  Future<void> reduceQuantity(Cart data);
  Future<void> deleteAllCarts();
}
