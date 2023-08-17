import 'package:beliyuk/data/datasources/local/cart_local_data_source.dart';
import 'package:beliyuk/data/models/cart_model.dart';
import 'package:beliyuk/domain/entities/cart.dart';
import 'package:beliyuk/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<String> addCart(Cart data) async {
    await localDataSource.addCart(CartModel.fromEntity(data));
    return 'Berhasil menambahkan ke keranjang';
  }

  @override
  Future<void> addQuantity(Cart data) async {
    await localDataSource.addQuantity(CartModel.fromEntity(data));
  }

  @override
  Future<void> deleteAllCarts() async {
    await localDataSource.deleteAllCarts();
  }

  @override
  Future<List<Cart>> getAllCarts() async {
    final result = await localDataSource.getAllCarts();
    return List<Cart>.from(result.map((item) => item.toEntity()));
  }

  @override
  Future<Cart?> getCartById(int id) async {
    final result = await localDataSource.getCartById(id);
    if (result != null) return result.toEntity();
    return null;
  }

  @override
  Future<void> reduceQuantity(Cart data) async {
    await localDataSource.reduceQuantity(CartModel.fromEntity(data));
  }

  @override
  Future<String> removeCart(int id) async {
    await localDataSource.removeCart(id);
    return 'Berhasil menghapus dari keranjang';
  }
}
