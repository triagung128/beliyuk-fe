part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<Cart> items;
  final int totalPrice;
  final int totalItems;

  const CartLoaded({
    required this.items,
    required this.totalPrice,
    required this.totalItems,
  });

  @override
  List<Object> get props => [items, totalPrice, totalItems];
}
