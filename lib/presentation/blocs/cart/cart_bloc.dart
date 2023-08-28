import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/domain/entities/cart.dart';
import 'package:beliyuk/domain/usecases/cart/add_cart.dart';
import 'package:beliyuk/domain/usecases/cart/add_quantity.dart';
import 'package:beliyuk/domain/usecases/cart/delete_all_carts.dart';
import 'package:beliyuk/domain/usecases/cart/get_all_carts.dart';
import 'package:beliyuk/domain/usecases/cart/get_cart_by_id.dart';
import 'package:beliyuk/domain/usecases/cart/reduce_quantity.dart';
import 'package:beliyuk/domain/usecases/cart/remove_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetAllCarts getAllCarts;
  final GetCartById getCartById;
  final AddCart addCart;
  final RemoveCart removeCart;
  final AddQuantity addQuantity;
  final ReduceQuantity reduceQuantity;
  final DeleteAllCarts deleteAllCarts;

  CartBloc({
    required this.getAllCarts,
    required this.getCartById,
    required this.addCart,
    required this.removeCart,
    required this.addQuantity,
    required this.reduceQuantity,
    required this.deleteAllCarts,
  }) : super(CartInitial()) {
    on<DoGetAllCartEvent>((event, emit) async {
      final items = await _getAllCarts();
      final totalPrice = await _totalPrice();
      final totalItems = await _totalItems();
      final totalWeight = await _totalWeight();

      emit(CartLoaded(
        items: items,
        totalPrice: totalPrice,
        totalItems: totalItems,
        totalWeight: totalWeight,
      ));
    });

    on<AddCartEvent>((event, emit) async {
      final Cart? productExists = await getCartById.execute(event.cart.id);

      if (productExists != null) {
        await addQuantity.execute(productExists);
      } else {
        await addCart.execute(event.cart);
      }

      final items = await _getAllCarts();
      final totalPrice = await _totalPrice();
      final totalItems = await _totalItems();
      final totalWeight = await _totalWeight();

      emit(CartLoaded(
        items: items,
        totalPrice: totalPrice,
        totalItems: totalItems,
        totalWeight: totalWeight,
      ));
    });

    on<RemoveCartEvent>((event, emit) async {
      await removeCart.execute(event.id);

      final items = await _getAllCarts();
      final totalPrice = await _totalPrice();
      final totalItems = await _totalItems();
      final totalWeight = await _totalWeight();

      emit(CartLoaded(
        items: items,
        totalPrice: totalPrice,
        totalItems: totalItems,
        totalWeight: totalWeight,
      ));
    });

    on<AddQuantityEvent>((event, emit) async {
      await addQuantity.execute(event.cart);

      final items = await _getAllCarts();
      final totalPrice = await _totalPrice();
      final totalItems = await _totalItems();
      final totalWeight = await _totalWeight();

      emit(CartLoaded(
        items: items,
        totalPrice: totalPrice,
        totalItems: totalItems,
        totalWeight: totalWeight,
      ));
    });

    on<ReduceQuantityEvent>((event, emit) async {
      await reduceQuantity.execute(event.cart);

      final items = await _getAllCarts();
      final totalPrice = await _totalPrice();
      final totalItems = await _totalItems();
      final totalWeight = await _totalWeight();

      emit(CartLoaded(
        items: items,
        totalPrice: totalPrice,
        totalItems: totalItems,
        totalWeight: totalWeight,
      ));
    });

    on<DeleteAllCartEvent>((event, emit) async {
      await deleteAllCarts.execute();

      final items = await _getAllCarts();
      final totalPrice = await _totalPrice();
      final totalItems = await _totalItems();
      final totalWeight = await _totalWeight();

      emit(CartLoaded(
        items: items,
        totalPrice: totalPrice,
        totalItems: totalItems,
        totalWeight: totalWeight,
      ));
    });
  }

  Future<List<Cart>> _getAllCarts() async {
    return await getAllCarts.execute();
  }

  Future<int> _totalItems() async {
    int total = 0;

    final carts = await _getAllCarts();

    for (var item in carts) {
      total += item.quantity;
    }

    return total;
  }

  Future<int> _totalPrice() async {
    int total = 0;

    final carts = await _getAllCarts();

    for (var item in carts) {
      total += (item.quantity * item.price);
    }

    return total;
  }

  Future<int> _totalWeight() async {
    int total = 0;

    final carts = await _getAllCarts();

    for (var item in carts) {
      total += (item.quantity * item.weight);
    }

    return total;
  }
}
