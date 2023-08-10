part of 'search_product_bloc.dart';

sealed class SearchProductState extends Equatable {
  const SearchProductState();

  @override
  List<Object> get props => [];
}

final class SearchProductInitial extends SearchProductState {}

final class SearchProductLoading extends SearchProductState {}

final class SearchProductLoaded extends SearchProductState {
  final ListProductResponseModel data;

  const SearchProductLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class SearchProductError extends SearchProductState {
  final String messageError;

  const SearchProductError(this.messageError);

  @override
  List<Object> get props => [messageError];
}
