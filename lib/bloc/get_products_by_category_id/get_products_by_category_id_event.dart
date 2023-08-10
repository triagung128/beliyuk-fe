part of 'get_products_by_category_id_bloc.dart';

sealed class GetProductsByCategoryIdEvent extends Equatable {
  const GetProductsByCategoryIdEvent();

  @override
  List<Object> get props => [];
}

final class DoGetProductsByCategoryIdEvent
    extends GetProductsByCategoryIdEvent {
  final int idCategory;

  const DoGetProductsByCategoryIdEvent(this.idCategory);

  @override
  List<Object> get props => [idCategory];
}
