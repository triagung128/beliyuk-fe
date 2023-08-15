part of 'detail_product_bloc.dart';

sealed class DetailProductEvent extends Equatable {
  const DetailProductEvent();

  @override
  List<Object> get props => [];
}

final class FetchDetailProductEvent extends DetailProductEvent {
  final int id;

  const FetchDetailProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

final class AddWishlistDetailProductEvent extends DetailProductEvent {
  final WishlistRequestModel requestData;

  const AddWishlistDetailProductEvent(this.requestData);

  @override
  List<Object> get props => [requestData];
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
