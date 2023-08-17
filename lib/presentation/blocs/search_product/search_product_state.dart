part of 'search_product_bloc.dart';

sealed class SearchProductState extends Equatable {
  const SearchProductState();

  @override
  List<Object> get props => [];
}

final class SearchProductInitial extends SearchProductState {}

final class SearchProductLoading extends SearchProductState {}

final class SearchProductLoaded extends SearchProductState {
  final List<Product> products;

  const SearchProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class SearchProductError extends SearchProductState {
  final String message;

  const SearchProductError(this.message);

  @override
  List<Object> get props => [message];
}
