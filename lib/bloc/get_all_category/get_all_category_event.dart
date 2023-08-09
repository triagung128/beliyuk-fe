part of 'get_all_category_bloc.dart';

sealed class GetAllCategoryEvent extends Equatable {
  const GetAllCategoryEvent();

  @override
  List<Object> get props => [];
}

final class DoGetAllCategoryEvent extends GetAllCategoryEvent {}
