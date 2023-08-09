part of 'get_all_product_bloc.dart';

sealed class GetAllProductState extends Equatable {
  const GetAllProductState();

  @override
  List<Object> get props => [];
}

final class GetAllProductInitial extends GetAllProductState {}

final class GetAllProductLoading extends GetAllProductState {}

final class GetAllProductLoaded extends GetAllProductState {
  final ListProductResponseModel data;

  const GetAllProductLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class GetAllProductError extends GetAllProductState {
  final String messageError;

  const GetAllProductError(this.messageError);

  @override
  List<Object> get props => [messageError];
}
