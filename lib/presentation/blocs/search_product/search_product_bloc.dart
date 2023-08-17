import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/domain/entities/product.dart';
import 'package:beliyuk/domain/usecases/product/search_products.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final SearchProducts searchProducts;

  SearchProductBloc({required this.searchProducts})
      : super(SearchProductInitial()) {
    on<DoSearchProductEvent>((event, emit) async {
      emit(SearchProductLoading());

      final result = await searchProducts.execute(event.query);

      result.fold(
        (failure) => emit(SearchProductError(failure.message)),
        (data) => emit(SearchProductLoaded(data)),
      );
    });
  }
}
