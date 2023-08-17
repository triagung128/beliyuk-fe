import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/domain/entities/wishlist.dart';
import 'package:beliyuk/injection.dart' as di;
import 'package:beliyuk/presentation/blocs/wishlist/wishlist_bloc.dart';
import 'package:beliyuk/presentation/common_widgets/custom_appbar_with_cart_icon.dart';
import 'package:beliyuk/presentation/pages/wishlist/widgets/item_wishlist.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.locator<WishlistBloc>()..add(DoGetAllWishlistEvent()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBarWithCartIcon(
          automaticallyImplyLeading: false,
          title: Text('Wishlist'),
        ),
        body: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is WishlistLoaded) {
              if (state.data.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        context
                            .read<WishlistBloc>()
                            .add(DoGetAllWishlistEvent());
                      },
                    );
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.0 / 1.6,
                    ),
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final Wishlist wishlist = state.data[index];
                      return ItemWishlist(wishlist: wishlist);
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text('Data Kosong'),
                );
              }
            }

            if (state is WishlistError) {
              return Center(
                child: Text(state.message),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
