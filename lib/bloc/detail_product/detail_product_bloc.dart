import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/enum_state.dart';
import 'package:beliyuk/data/datasources/remote/product_remote_datasource.dart';
import 'package:beliyuk/data/datasources/remote/wishlist_remote_datasource.dart';
import 'package:beliyuk/data/models/product_model.dart';
import 'package:beliyuk/data/models/requests/wishlist_request_model.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  static const wishlistAddSuccessMessage = 'Berhasil ditambahkan ke wishlist';
  static const wishlistRemoveSuccessMessage = 'Berhasil dihapus dari wishlist';

  final ProductRemoteDatasource productRemoteDatasource;
  final WishlistRemoteDatasource wishlistRemoteDatasource;

  DetailProductBloc({
    required this.productRemoteDatasource,
    required this.wishlistRemoteDatasource,
  }) : super(DetailProductState.inital()) {
    on<FetchDetailProductEvent>((event, emit) async {
      emit(
        state.copyWith(
          state: RequestState.loading,
        ),
      );

      final result = await productRemoteDatasource.getProductById(event.id);

      result.fold(
        (messageError) => emit(
          state.copyWith(
            state: RequestState.error,
            message: messageError,
          ),
        ),
        (data) => emit(
          state.copyWith(
            state: RequestState.loaded,
            product: data.data,
          ),
        ),
      );
    });

    on<AddWishlistDetailProductEvent>((event, emit) async {
      emit(state.copyWith(wishlistMessage: ''));

      final result =
          await wishlistRemoteDatasource.addWishlist(event.requestData);

      result.fold(
        (messageError) => emit(state.copyWith(wishlistMessage: messageError)),
        (messageSuccess) =>
            emit(state.copyWith(wishlistMessage: wishlistAddSuccessMessage)),
      );

      add(LoadWishlistStatusEvent(event.requestData.productId));
    });

    on<RemoveWishlistDetailProductEvent>((event, emit) async {
      emit(state.copyWith(wishlistMessage: ''));

      final result = await wishlistRemoteDatasource.removeWishlist(event.id);

      result.fold(
        (messageError) => emit(state.copyWith(wishlistMessage: messageError)),
        (messageSuccess) =>
            emit(state.copyWith(wishlistMessage: wishlistRemoveSuccessMessage)),
      );

      add(LoadWishlistStatusEvent(event.id));
    });

    on<LoadWishlistStatusEvent>((event, emit) async {
      final data =
          await wishlistRemoteDatasource.getWishlistByProductId(event.id);

      if (data != null) {
        emit(state.copyWith(isAddedToWishlist: true));
      } else {
        emit(state.copyWith(isAddedToWishlist: false));
      }
    });
  }
}
