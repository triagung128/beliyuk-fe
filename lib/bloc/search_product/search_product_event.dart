part of 'search_product_bloc.dart';

sealed class SearchProductEvent extends Equatable {
  const SearchProductEvent();

  @override
  List<Object> get props => [];
}

final class DoSearchProductEvent extends SearchProductEvent {
  final String productName;

  const DoSearchProductEvent({required this.productName});

  @override
  List<Object> get props => [productName];
}
