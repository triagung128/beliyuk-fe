part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class AddCartEvent extends CartEvent {
  final ProductModel product;

  const AddCartEvent(this.product);

  @override
  List<Object> get props => [product];
}

final class RemoveCartEvent extends CartEvent {
  final ProductModel product;

  const RemoveCartEvent(this.product);

  @override
  List<Object> get props => [product];
}

final class AddQuantityEvent extends CartEvent {
  final ProductModel product;

  const AddQuantityEvent(this.product);

  @override
  List<Object> get props => [product];
}

final class ReduceQuantityEvent extends CartEvent {
  final ProductModel product;

  const ReduceQuantityEvent(this.product);

  @override
  List<Object> get props => [product];
}
