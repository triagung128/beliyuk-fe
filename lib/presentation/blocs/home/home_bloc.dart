import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/enum_state.dart';
import 'package:beliyuk/domain/entities/banner.dart';
import 'package:beliyuk/domain/entities/category.dart';
import 'package:beliyuk/domain/entities/product.dart';
import 'package:beliyuk/domain/usecases/banner/get_all_banners.dart';
import 'package:beliyuk/domain/usecases/category/get_all_categories.dart';
import 'package:beliyuk/domain/usecases/product/get_all_products.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllBanners getAllBanners;
  final GetAllCategories getAllCategories;
  final GetAllProducts getAllProducts;

  HomeBloc({
    required this.getAllBanners,
    required this.getAllCategories,
    required this.getAllProducts,
  }) : super(HomeState.initial()) {
    on<DoGetAllBanners>((event, emit) async {
      emit(state.copyWith(bannersState: RequestState.loading));

      final result = await getAllBanners.execute();

      result.fold(
        (failure) => emit(
          state.copyWith(
            bannersState: RequestState.error,
            bannersMessage: failure.message,
          ),
        ),
        (data) => emit(
          state.copyWith(
            bannersState: RequestState.loaded,
            banners: data,
          ),
        ),
      );
    });

    on<DoGetAllCategories>((event, emit) async {
      emit(state.copyWith(categoriesState: RequestState.loading));

      final result = await getAllCategories.execute();

      result.fold(
        (failure) => emit(
          state.copyWith(
            categoriesState: RequestState.error,
            categoriesMessage: failure.message,
          ),
        ),
        (data) => emit(
          state.copyWith(
            categoriesState: RequestState.loaded,
            categories: data,
          ),
        ),
      );
    });

    on<DoGetAllProducts>((event, emit) async {
      emit(state.copyWith(productsState: RequestState.loading));

      final result = await getAllProducts.execute();

      result.fold(
        (failure) => emit(
          state.copyWith(
            productsState: RequestState.error,
            productsMessage: failure.message,
          ),
        ),
        (data) => emit(
          state.copyWith(
            productsState: RequestState.loaded,
            products: data,
          ),
        ),
      );
    });
  }
}
