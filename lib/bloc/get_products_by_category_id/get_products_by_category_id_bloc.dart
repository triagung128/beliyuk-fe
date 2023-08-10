import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/data/datasources/product_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/data/models/responses/list_product_response_model.dart';

part 'get_products_by_category_id_event.dart';
part 'get_products_by_category_id_state.dart';

class GetProductsByCategoryIdBloc
    extends Bloc<GetProductsByCategoryIdEvent, GetProductsByCategoryIdState> {
  final ProductRemoteDatasource _datasource;

  GetProductsByCategoryIdBloc(this._datasource)
      : super(GetProductsByCategoryIdInitial()) {
    on<DoGetProductsByCategoryIdEvent>((event, emit) async {
      emit(GetProductsByCategoryIdLoading());

      final result =
          await _datasource.getProductsByCategoryId(event.idCategory);

      result.fold(
        (messageError) => emit(GetProductsByCategoryIdError(messageError)),
        (data) => emit(GetProductsByCategoryIdLoaded(data)),
      );
    });
  }
}
