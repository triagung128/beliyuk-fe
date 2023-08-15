part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

final class DoGetAllWishlistEvent extends WishlistEvent {}

final class DoRefreshGetAllWishlistEvent extends WishlistEvent {}

final class DoRemoveWishlistEvent extends WishlistEvent {
  final int productId;

  const DoRemoveWishlistEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
