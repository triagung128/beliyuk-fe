part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final ListProductResponseModel data;

  const CategoryLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class CategoryError extends CategoryState {
  final String messageError;

  const CategoryError(this.messageError);

  @override
  List<Object> get props => [messageError];
}
