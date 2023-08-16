import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/bloc/detail_product/detail_product_bloc.dart';
import 'package:beliyuk/common/global_variables.dart';
import 'package:beliyuk/common/int_extensions.dart';
import 'package:beliyuk/data/models/product_model.dart';
import 'package:beliyuk/data/models/requests/wishlist_request_model.dart';

class DetailProductContent extends StatelessWidget {
  const DetailProductContent({
    required this.product,
    required this.isAddedToWishlist,
    super.key,
  });

  final ProductModel product;
  final bool isAddedToWishlist;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl:
                '${GlobalVariables.baseUrl}${product.attributes.images.data[0].attributes.url}',
            imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: imageProvider,
                ),
              ),
            ),
            progressIndicatorBuilder: (_, __, progress) => SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 350,
              child: Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
            ),
            errorWidget: (context, _, __) => Container(
              width: MediaQuery.of(context).size.width,
              height: 350,
              decoration: BoxDecoration(
                color: Colors.grey[350],
              ),
              child: const Icon(Icons.broken_image, size: 62),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.attributes.price.intToFormatRupiah,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (!isAddedToWishlist) {
                          final requestData = WishlistRequestModel(
                            productId: product.id,
                            name: product.attributes.name,
                            price: product.attributes.price,
                            image: product
                                .attributes.images.data.first.attributes.url,
                          );

                          context
                              .read<DetailProductBloc>()
                              .add(AddWishlistDetailProductEvent(requestData));
                        } else {
                          context.read<DetailProductBloc>().add(
                              RemoveWishlistDetailProductEvent(product.id));
                        }
                      },
                      icon: Icon(
                        isAddedToWishlist
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  product.attributes.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(thickness: 0.5),
                const SizedBox(height: 8),
                const Text(
                  'Detail Produk',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Table(
                  children: [
                    TableRow(
                      children: [
                        const Text('Berat satuan'),
                        Text(product.attributes.weight.convertUnitWeight),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('Kategori'),
                        Text(product.attributes.category.data.attributes.name),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(thickness: 0.5),
                const SizedBox(height: 8),
                const Text(
                  'Deskripsi Produk',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(product.attributes.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
