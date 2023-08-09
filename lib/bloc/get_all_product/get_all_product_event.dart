part of 'get_all_product_bloc.dart';

sealed class GetAllProductEvent extends Equatable {
  const GetAllProductEvent();

  @override
  List<Object> get props => [];
}

final class DoGetAllProductEvent extends GetAllProductEvent {}
