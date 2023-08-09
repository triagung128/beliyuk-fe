part of 'get_all_category_bloc.dart';

sealed class GetAllCategoryState extends Equatable {
  const GetAllCategoryState();

  @override
  List<Object> get props => [];
}

final class GetAllCategoryInitial extends GetAllCategoryState {}

final class GetAllCategoryLoading extends GetAllCategoryState {}

final class GetAllCategoryLoaded extends GetAllCategoryState {
  final ListCategoryResponseModel data;

  const GetAllCategoryLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class GetAllCategoryError extends GetAllCategoryState {
  final String messageError;

  const GetAllCategoryError(this.messageError);

  @override
  List<Object> get props => [messageError];
}
