part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class DoGetAllCartEvent extends CartEvent {}

final class AddCartEvent extends CartEvent {
  final Cart cart;

  const AddCartEvent(this.cart);

  @override
  List<Object> get props => [cart];
}

final class RemoveCartEvent extends CartEvent {
  final int id;

  const RemoveCartEvent(this.id);

  @override
  List<Object> get props => [id];
}

final class AddQuantityEvent extends CartEvent {
  final Cart cart;

  const AddQuantityEvent(this.cart);

  @override
  List<Object> get props => [cart];
}

final class ReduceQuantityEvent extends CartEvent {
  final Cart cart;

  const ReduceQuantityEvent(this.cart);

  @override
  List<Object> get props => [cart];
}

final class DeleteAllCartEvent extends CartEvent {}
