import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/data/datasources/local/cart_local_datasource.dart';
import 'package:fic6_fe_beliyuk/data/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartLocalDatasource _datasource;

  CartBloc(this._datasource) : super(CartInitial()) {
    on<DoGetAllCartEvent>((event, emit) async {
      final items = await _getCarts();
      final totalPrice = await _totalPrice();
      final totalItems = await _totalItems();

      emit(CartLoaded(
        items: items,
        totalPrice: totalPrice,
        totalItems: totalItems,
      ));
    });

    on<AddCartEvent>((event, emit) async {
      final CartModel? productExists =
          await _datasource.getCartById(event.cart.id);

      if (productExists != null) {
        await _datasource.addQuantity(productExists);
      } else {
        await _datasource.addCart(event.cart);
      }

      final items = await _getCarts();
      final totalPrice = await _totalPrice();
      final totalItems = await _totalItems();

      emit(CartLoaded(
        items: items,
        totalPrice: totalPrice,
        totalItems: totalItems,
      ));
    });

    on<RemoveCartEvent>((event, emit) async {
      await _datasource.removeCart(event.id);

      final items = await _getCarts();
      final totalPrice = await _totalPrice();
      final totalItems = await _totalItems();

      emit(CartLoaded(
        items: items,
        totalPrice: totalPrice,
        totalItems: totalItems,
      ));
    });

    on<AddQuantityEvent>((event, emit) async {
      await _datasource.addQuantity(event.cart);

      final items = await _getCarts();
      final totalPrice = await _totalPrice();
      final totalItems = await _totalItems();

      emit(CartLoaded(
        items: items,
        totalPrice: totalPrice,
        totalItems: totalItems,
      ));
    });

    on<ReduceQuantityEvent>((event, emit) async {
      await _datasource.reduceQuantity(event.cart);

      final items = await _getCarts();
      final totalPrice = await _totalPrice();
      final totalItems = await _totalItems();

      emit(CartLoaded(
        items: items,
        totalPrice: totalPrice,
        totalItems: totalItems,
      ));
    });

    on<DeleteAllCartEvent>((event, emit) async {
      await _datasource.deleteCarts();

      final items = await _getCarts();
      final totalPrice = await _totalPrice();
      final totalItems = await _totalItems();

      emit(CartLoaded(
        items: items,
        totalPrice: totalPrice,
        totalItems: totalItems,
      ));
    });
  }

  Future<List<CartModel>> _getCarts() async {
    return await _datasource.getCarts();
  }

  Future<int> _totalItems() async {
    int total = 0;

    final carts = await _getCarts();

    for (var item in carts) {
      total += item.quantity;
    }

    return total;
  }

  Future<int> _totalPrice() async {
    int total = 0;

    final carts = await _getCarts();

    for (var item in carts) {
      total += (item.quantity * item.price);
    }

    return total;
  }
}
