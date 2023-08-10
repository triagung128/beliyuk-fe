part of 'get_products_by_category_id_bloc.dart';

sealed class GetProductsByCategoryIdState extends Equatable {
  const GetProductsByCategoryIdState();

  @override
  List<Object> get props => [];
}

final class GetProductsByCategoryIdInitial
    extends GetProductsByCategoryIdState {}

final class GetProductsByCategoryIdLoading
    extends GetProductsByCategoryIdState {}

final class GetProductsByCategoryIdLoaded extends GetProductsByCategoryIdState {
  final ListProductResponseModel data;

  const GetProductsByCategoryIdLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class GetProductsByCategoryIdError extends GetProductsByCategoryIdState {
  final String messageError;

  const GetProductsByCategoryIdError(this.messageError);

  @override
  List<Object> get props => [messageError];
}
