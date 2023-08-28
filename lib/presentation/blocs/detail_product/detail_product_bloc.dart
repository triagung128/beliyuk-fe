import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/enum_state.dart';
import 'package:beliyuk/domain/entities/product.dart';
import 'package:beliyuk/domain/entities/wishlist.dart';
import 'package:beliyuk/domain/usecases/auth/get_auth.dart';
import 'package:beliyuk/domain/usecases/product/get_product_by_id.dart';
import 'package:beliyuk/domain/usecases/wishlist/add_wishlist.dart';
import 'package:beliyuk/domain/usecases/wishlist/get_wishlist_by_product_id.dart';
import 'package:beliyuk/domain/usecases/wishlist/remove_wishlist.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  static const wishlistAddSuccessMessage = 'Ditambahkan ke wishlist';
  static const wishlistRemoveSuccessMessage = 'Dihapus dari wishlist';

  final GetProductById getProductById;
  final GetAuth getAuth;
  final AddWishlist addWishlist;
  final RemoveWishlist removeWishlist;
  final GetWishlistByProductId getWishlistByProductId;

  DetailProductBloc({
    required this.getProductById,
    required this.getAuth,
    required this.addWishlist,
    required this.removeWishlist,
    required this.getWishlistByProductId,
  }) : super(DetailProductState.inital()) {
    on<FetchDetailProductEvent>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));

      final result = await getProductById.execute(event.productId);

      result.fold(
        (failure) => emit(
          state.copyWith(
            state: RequestState.error,
            message: failure.message,
          ),
        ),
        (data) => emit(
          state.copyWith(
            state: RequestState.loaded,
            product: data,
          ),
        ),
      );
    });

    on<AddWishlistDetailProductEvent>((event, emit) async {
      emit(state.copyWith(wishlistMessage: ''));

      final auth = await getAuth.execute();

      if (auth != null) {
        final int userId = auth.id;
        final String token = auth.token;

        final Wishlist data = Wishlist(
          userId: userId,
          productId: event.productId,
          name: event.name,
          price: event.price,
          weight: event.weight,
          image: event.image,
        );

        final result = await addWishlist.execute(
          userId: userId,
          token: token,
          data: data,
        );

        result.fold(
          (failure) => emit(state.copyWith(wishlistMessage: failure.message)),
          (messageSuccess) =>
              emit(state.copyWith(wishlistMessage: wishlistAddSuccessMessage)),
        );

        add(LoadWishlistStatusEvent(data.productId));
      } else {
        emit(state.copyWith(wishlistMessage: 'Anda belum login !'));
      }
    });

    on<RemoveWishlistDetailProductEvent>((event, emit) async {
      emit(state.copyWith(wishlistMessage: ''));

      final auth = await getAuth.execute();

      if (auth != null) {
        final int userId = auth.id;
        final String token = auth.token;
        final int productId = event.id;

        final result = await removeWishlist.execute(
          userId: userId,
          token: token,
          productId: productId,
        );

        result.fold(
          (failure) => emit(state.copyWith(wishlistMessage: failure.message)),
          (messageSuccess) => emit(
              state.copyWith(wishlistMessage: wishlistRemoveSuccessMessage)),
        );
      } else {
        emit(state.copyWith(wishlistMessage: 'Anda belum login !'));
      }

      add(LoadWishlistStatusEvent(event.id));
    });

    on<LoadWishlistStatusEvent>((event, emit) async {
      final auth = await getAuth.execute();

      if (auth != null) {
        final int userId = auth.id;
        final String token = auth.token;
        final int productId = event.id;

        final result = await getWishlistByProductId.execute(
          userId: userId,
          token: token,
          productId: productId,
        );

        result.fold(
          (failure) => emit(state.copyWith(wishlistMessage: failure.message)),
          (isWishlist) => emit(state.copyWith(isAddedToWishlist: isWishlist)),
        );
      }
    });
  }
}
