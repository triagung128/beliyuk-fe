import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/constants.dart';
import 'package:beliyuk/common/int_extensions.dart';
import 'package:beliyuk/domain/entities/cart.dart';
import 'package:beliyuk/domain/entities/wishlist.dart';
import 'package:beliyuk/presentation/blocs/cart/cart_bloc.dart';
import 'package:beliyuk/presentation/blocs/wishlist/wishlist_bloc.dart';
import 'package:beliyuk/presentation/pages/detail_product/detail_product_page.dart';

class ItemWishlist extends StatelessWidget {
  const ItemWishlist({
    super.key,
    required this.wishlist,
  });

  final Wishlist wishlist;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 2,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: '${Urls.baseUrl}${wishlist.image}',
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      image: DecorationImage(image: imageProvider),
                    ),
                  ),
                  progressIndicatorBuilder: (_, __, progress) => Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                  errorWidget: (context, _, __) => Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 32),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DetailProductPage(
                              productId: wishlist.productId)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wishlist.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        wishlist.price.intToFormatRupiah,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            final Cart cart = Cart(
                              id: wishlist.productId,
                              name: wishlist.name,
                              price: wishlist.price,
                              image: wishlist.image,
                            );
                            context.read<CartBloc>().add(AddCartEvent(cart));
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              width: 1,
                              color: Colors.blue,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text('Keranjang'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 6,
          child: Material(
            elevation: 8,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () {
                context
                    .read<WishlistBloc>()
                    .add(DoRemoveWishlistEvent(wishlist.productId));
              },
              customBorder: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(7),
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
