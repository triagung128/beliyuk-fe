import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/data/datasources/remote/product_remote_datasource.dart';
import 'package:beliyuk/data/models/responses/list_product_response_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ProductRemoteDatasource _datasource;

  CategoryBloc(this._datasource) : super(CategoryInitial()) {
    on<DoGetAllProductsByCategoryIdEvent>((event, emit) async {
      emit(CategoryLoading());

      final result =
          await _datasource.getProductsByCategoryId(event.categoryId);

      result.fold(
        (messageError) => emit(CategoryError(messageError)),
        (data) => emit(CategoryLoaded(data)),
      );
    });
  }
}
