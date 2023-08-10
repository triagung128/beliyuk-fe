import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/data/datasources/product_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/data/models/responses/list_product_response_model.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final ProductRemoteDatasource _datasource;

  SearchProductBloc(this._datasource) : super(SearchProductInitial()) {
    on<DoSearchProductEvent>((event, emit) async {
      emit(SearchProductLoading());

      final result = await _datasource.searchProduct(event.productName);

      result.fold(
        (messageError) => emit(SearchProductError(messageError)),
        (data) => emit(SearchProductLoaded(data)),
      );
    });
  }
}
