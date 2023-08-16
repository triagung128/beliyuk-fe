import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/bloc/detail_product/detail_product_bloc.dart';
import 'package:beliyuk/common/enum_state.dart';
import 'package:beliyuk/data/datasources/local/auth_local_datasource.dart';
import 'package:beliyuk/data/datasources/remote/product_remote_datasource.dart';
import 'package:beliyuk/data/datasources/remote/wishlist_remote_datasource.dart';
import 'package:beliyuk/presentation/common_widgets/custom_appbar_with_cart_icon.dart';
import 'package:beliyuk/presentation/pages/detail_product/widgets/button_add_cart.dart';
import 'package:beliyuk/presentation/pages/detail_product/widgets/detail_product_content.dart';

class DetailProductPage extends StatelessWidget {
  DetailProductPage({
    super.key,
    required this.productId,
  });

  final int productId;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailProductBloc(
        productRemoteDatasource: ProductRemoteDatasource(),
        wishlistRemoteDatasource:
            WishlistRemoteDatasource(AuthLocalDatasource()),
      )
        ..add(FetchDetailProductEvent(productId))
        ..add(LoadWishlistStatusEvent(productId)),
      child: ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: Scaffold(
          appBar: const CustomAppBarWithCartIcon(
            centerTitle: true,
            title: Text('Detail Produk'),
          ),
          body: BlocConsumer<DetailProductBloc, DetailProductState>(
            listener: (context, state) {
              final message = state.wishlistMessage;

              if (message == DetailProductBloc.wishlistAddSuccessMessage ||
                  message == DetailProductBloc.wishlistRemoveSuccessMessage) {
                _scaffoldMessengerKey.currentState!
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(message)));
              } else {
                _scaffoldMessengerKey.currentState!
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red[400],
                  ));
              }
            },
            listenWhen: (oldState, newState) {
              return oldState.wishlistMessage != newState.wishlistMessage &&
                  newState.wishlistMessage != '';
            },
            builder: (context, state) {
              if (state.state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                );
              }

              if (state.state == RequestState.loaded) {
                return DetailProductContent(
                  product: state.product!,
                  isAddedToWishlist: state.isAddedToWishlist,
                );
              }

              if (state.state == RequestState.error) {
                return Center(
                  child: Text(state.message),
                );
              }

              return Container();
            },
          ),
          bottomNavigationBar:
              BlocBuilder<DetailProductBloc, DetailProductState>(
            builder: (context, state) {
              if (state.state == RequestState.loaded) {
                return ButtonAddCart(product: state.product!);
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
