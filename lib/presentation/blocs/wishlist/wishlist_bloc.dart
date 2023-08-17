import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/domain/entities/wishlist.dart';
import 'package:beliyuk/domain/usecases/auth/get_auth.dart';
import 'package:beliyuk/domain/usecases/wishlist/get_all_wishlists.dart';
import 'package:beliyuk/domain/usecases/wishlist/remove_wishlist.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final GetAuth getAuth;
  final GetAllWishlists getAllWishlists;
  final RemoveWishlist removeWishlist;

  WishlistBloc({
    required this.getAuth,
    required this.getAllWishlists,
    required this.removeWishlist,
  }) : super(WishlistInitial()) {
    on<DoGetAllWishlistEvent>((event, emit) async {
      emit(WishlistLoading());

      final user = await getAuth.execute();

      if (user != null) {
        final String token = user.token;
        final int userId = user.id;

        final result = await getAllWishlists.execute(
          token: token,
          userId: userId,
        );

        result.fold(
          (failure) => emit(WishlistError(failure.message)),
          (data) => emit(WishlistLoaded(data)),
        );
      } else {
        emit(const WishlistError('Anda belum login !'));
      }
    });

    on<DoRemoveWishlistEvent>((event, emit) async {
      final user = await getAuth.execute();

      if (user != null) {
        final String token = user.token;
        final int userId = user.id;
        final int productId = event.productId;

        final result = await removeWishlist.execute(
          token: token,
          userId: userId,
          productId: productId,
        );

        result.fold(
          (failure) => emit(WishlistError(failure.message)),
          (_) => add(DoGetAllWishlistEvent()),
        );
      } else {
        emit(const WishlistError('Anda belum login !'));
      }
    });
  }
}
