part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

final class DoGetAllProductsByCategoryIdEvent extends CategoryEvent {
  final int categoryId;

  const DoGetAllProductsByCategoryIdEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
