import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/domain/entities/product.dart';
import 'package:beliyuk/domain/usecases/product/get_all_products_by_category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllProductsByCategory getAllProductsByCategory;

  CategoryBloc({required this.getAllProductsByCategory})
      : super(CategoryInitial()) {
    on<DoGetAllProductsByCategoryIdEvent>((event, emit) async {
      emit(CategoryLoading());

      final result = await getAllProductsByCategory.execute(event.categoryId);

      result.fold(
        (failure) => emit(CategoryError(failure.message)),
        (data) => emit(CategoryLoaded(data)),
      );
    });
  }
}
