import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/data/models/cart_model.dart';
import 'package:fic6_fe_beliyuk/data/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartModel> _carts = [];

  CartBloc() : super(CartInitial()) {
    on<AddCartEvent>((event, emit) {
      if (_productExists(event.product)) {
        int index =
            _carts.indexWhere((item) => item.product.id == event.product.id);
        _carts[index].qty++;
      } else {
        _carts.add(CartModel(product: event.product, qty: 1));
      }

      emit(CartLoaded(
        items: _carts,
        totalItems: _totalItems(),
        totalPrice: _totalPrice(),
      ));
    });

    on<RemoveCartEvent>((event, emit) {
      int index =
          _carts.indexWhere((item) => item.product.id == event.product.id);
      _carts.removeAt(index);

      emit(CartLoaded(
        items: _carts,
        totalItems: _totalItems(),
        totalPrice: _totalPrice(),
      ));
    });

    on<AddQuantityEvent>((event, emit) {
      int index =
          _carts.indexWhere((item) => item.product.id == event.product.id);
      _carts[index].qty++;

      emit(CartLoaded(
        items: _carts,
        totalItems: _totalItems(),
        totalPrice: _totalPrice(),
      ));
    });

    on<ReduceQuantityEvent>((event, emit) {
      int index =
          _carts.indexWhere((item) => item.product.id == event.product.id);
      _carts[index].qty--;

      if (_carts[index].qty == 0) {
        _carts.removeAt(index);
      }

      emit(CartLoaded(
        items: _carts,
        totalItems: _totalItems(),
        totalPrice: _totalPrice(),
      ));
    });
  }

  bool _productExists(ProductModel product) {
    if (_carts.indexWhere((item) => item.product.id == product.id) == -1) {
      return false;
    } else {
      return true;
    }
  }

  int _totalItems() {
    int total = 0;
    for (var item in _carts) {
      total += item.qty;
    }
    return total;
  }

  int _totalPrice() {
    int total = 0;
    for (var item in _carts) {
      total += (item.qty * item.product.attributes.price);
    }
    return total;
  }
}
