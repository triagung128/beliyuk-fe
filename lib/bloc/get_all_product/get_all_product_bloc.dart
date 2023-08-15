import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/data/datasources/remote/product_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/data/models/responses/list_product_response_model.dart';

part 'get_all_product_event.dart';
part 'get_all_product_state.dart';

class GetAllProductBloc extends Bloc<GetAllProductEvent, GetAllProductState> {
  final ProductRemoteDatasource _datasource;

  GetAllProductBloc(this._datasource) : super(GetAllProductInitial()) {
    on<DoGetAllProductEvent>((event, emit) async {
      emit(GetAllProductLoading());
      final result = await _datasource.getAllProduct();
      result.fold(
        (messageError) => emit(GetAllProductError(messageError)),
        (data) => emit(GetAllProductLoaded(data)),
      );
    });
  }
}
