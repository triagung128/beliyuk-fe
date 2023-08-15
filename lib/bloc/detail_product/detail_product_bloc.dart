import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/common/enum_state.dart';
import 'package:fic6_fe_beliyuk/data/datasources/product_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/data/models/product_model.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  final ProductRemoteDatasource _datasource;

  DetailProductBloc(this._datasource) : super(DetailProductState.inital()) {
    on<FetchDetailProductEvent>((event, emit) async {
      emit(
        state.copyWith(
          state: RequestState.loading,
        ),
      );

      final result = await _datasource.getProductById(event.id);

      result.fold(
        (messageError) => emit(
          state.copyWith(
            state: RequestState.error,
            message: messageError,
          ),
        ),
        (data) => emit(
          state.copyWith(
            product: data.data,
            state: RequestState.loaded,
          ),
        ),
      );
    });
  }
}
