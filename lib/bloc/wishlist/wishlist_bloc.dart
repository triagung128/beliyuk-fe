import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/data/datasources/remote/wishlist_remote_datasource.dart';
import 'package:beliyuk/data/models/responses/list_wishlist_response_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRemoteDatasource _datasource;

  WishlistBloc(this._datasource) : super(WishlistInitial()) {
    on<DoGetAllWishlistEvent>((event, emit) async {
      emit(WishlistLoading());

      final result = await _datasource.getAllWhislist();

      result.fold(
        (messageError) => emit(WishlistError(messageError)),
        (data) => emit(WishlistLoaded(data)),
      );
    });

    on<DoRefreshGetAllWishlistEvent>((event, emit) async {
      final result = await _datasource.getAllWhislist();

      result.fold(
        (messageError) => emit(WishlistError(messageError)),
        (data) => emit(WishlistLoaded(data)),
      );
    });

    on<DoRemoveWishlistEvent>((event, emit) async {
      final result = await _datasource.removeWishlist(event.productId);

      result.fold(
        (messageError) => emit(WishlistError(messageError)),
        (data) => add(DoGetAllWishlistEvent()),
      );
    });
  }
}
