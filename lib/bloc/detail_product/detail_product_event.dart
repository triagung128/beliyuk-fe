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
