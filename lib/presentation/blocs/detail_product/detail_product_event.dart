part of 'detail_product_bloc.dart';

sealed class DetailProductEvent extends Equatable {
  const DetailProductEvent();

  @override
  List<Object> get props => [];
}

final class FetchDetailProductEvent extends DetailProductEvent {
  final int productId;

  const FetchDetailProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

final class AddWishlistDetailProductEvent extends DetailProductEvent {
  final int productId;
  final String name;
  final int price;
  final int weight;
  final String image;

  const AddWishlistDetailProductEvent({
    required this.productId,
    required this.name,
    required this.price,
    required this.weight,
    required this.image,
  });

  @override
  List<Object> get props => [productId, name, price, weight, image];
}

final class RemoveWishlistDetailProductEvent extends DetailProductEvent {
  final int id;

  const RemoveWishlistDetailProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

final class LoadWishlistStatusEvent extends DetailProductEvent {
  final int id;

  const LoadWishlistStatusEvent(this.id);

  @override
  List<Object> get props => [id];
}
