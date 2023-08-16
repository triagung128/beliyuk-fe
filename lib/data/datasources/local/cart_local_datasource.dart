import 'package:beliyuk/data/database/database_helper.dart';
import 'package:beliyuk/data/models/cart_model.dart';

class CartLocalDatasource {
  final DatabaseHelper _databaseHelper;

  CartLocalDatasource(this._databaseHelper);

  Future<List<CartModel>> getCarts() async {
    try {
      final result = await _databaseHelper.getCarts();
      return result.map((item) => CartModel.fromMap(item)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CartModel?> getCartById(int id) async {
    try {
      final result = await _databaseHelper.getCartById(id);
      if (result != null) {
        return CartModel.fromMap(result);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> addCart(CartModel cart) async {
    try {
      await _databaseHelper.addCart(cart);
      return 'Berhasil menambahkan produk ke dalam keranjang';
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> removeCart(int id) async {
    try {
      await _databaseHelper.removeCart(id);
      return 'Berhasil menghapus produk dari keranjang';
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addQuantity(CartModel cart) async {
    try {
      await _databaseHelper.addQuantity(cart);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> reduceQuantity(CartModel cart) async {
    try {
      await _databaseHelper.reduceQuantity(cart);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteCarts() async {
    try {
      await _databaseHelper.deleteCarts();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
