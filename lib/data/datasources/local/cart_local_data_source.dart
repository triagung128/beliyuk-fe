import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/data/database/database_helper.dart';
import 'package:beliyuk/data/models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartModel>> getAllCarts();
  Future<CartModel?> getCartById(int id);
  Future<String> addCart(CartModel cart);
  Future<String> removeCart(int id);
  Future<void> addQuantity(CartModel cart);
  Future<void> reduceQuantity(CartModel cart);
  Future<void> deleteAllCarts();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final DatabaseHelper databaseHelper;

  CartLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<CartModel>> getAllCarts() async {
    try {
      final result = await databaseHelper.getCarts();
      return result.map((item) => CartModel.fromMap(item)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<CartModel?> getCartById(int id) async {
    try {
      final result = await databaseHelper.getCartById(id);
      if (result != null) {
        return CartModel.fromMap(result);
      } else {
        return null;
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> addCart(CartModel cart) async {
    try {
      await databaseHelper.addCart(cart);
      return 'Berhasil menambahkan produk ke dalam keranjang';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeCart(int id) async {
    try {
      await databaseHelper.removeCart(id);
      return 'Berhasil menghapus produk dari keranjang';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> addQuantity(CartModel cart) async {
    try {
      await databaseHelper.addQuantity(cart);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> reduceQuantity(CartModel cart) async {
    try {
      await databaseHelper.reduceQuantity(cart);
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<void> deleteAllCarts() async {
    try {
      await databaseHelper.deleteCarts();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
