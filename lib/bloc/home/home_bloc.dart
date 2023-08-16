import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/enum_state.dart';
import 'package:beliyuk/data/datasources/remote/banner_remote_datasource.dart';
import 'package:beliyuk/data/datasources/remote/category_remote_datasource.dart';
import 'package:beliyuk/data/datasources/remote/product_remote_datasource.dart';
import 'package:beliyuk/data/models/responses/list_banner_response_model.dart';
import 'package:beliyuk/data/models/responses/list_category_response_model.dart';
import 'package:beliyuk/data/models/responses/list_product_response_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BannerRemoteDatasource bannerRemoteDatasource;
  final CategoryRemoteDatasource categoryRemoteDatasource;
  final ProductRemoteDatasource productRemoteDatasource;

  HomeBloc({
    required this.bannerRemoteDatasource,
    required this.categoryRemoteDatasource,
    required this.productRemoteDatasource,
  }) : super(HomeState.initial()) {
    on<DoGetAllBanners>((event, emit) async {
      emit(state.copyWith(bannersState: RequestState.loading));

      final result = await bannerRemoteDatasource.getAllBanner();

      result.fold(
        (messageError) => emit(
          state.copyWith(
            bannersState: RequestState.error,
            bannersMessage: messageError,
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

      final result = await categoryRemoteDatasource.getAllCategory();

      result.fold(
        (messageError) => emit(
          state.copyWith(
            categoriesState: RequestState.error,
            categoriesMessage: messageError,
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

      final result = await productRemoteDatasource.getAllProduct();

      result.fold(
        (messageError) => emit(
          state.copyWith(
            productsState: RequestState.error,
            productsMessage: messageError,
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
