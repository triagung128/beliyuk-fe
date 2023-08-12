import 'package:cached_network_image/cached_network_image.dart';
import 'package:fic6_fe_beliyuk/data/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/bloc/cart/cart_bloc.dart';
import 'package:fic6_fe_beliyuk/common/global_variables.dart';
import 'package:fic6_fe_beliyuk/common/int_extensions.dart';
import 'package:fic6_fe_beliyuk/data/models/product_model.dart';
import 'package:fic6_fe_beliyuk/presentation/common_widgets/custom_appbar_with_cart_icon.dart';

class DetailProductPage extends StatelessWidget {
  final ProductModel product;
  final String tagHero;

  const DetailProductPage({
    super.key,
    required this.product,
    required this.tagHero,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWithCartIcon(
        centerTitle: true,
        title: Text('Detail Produk'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: tagHero,
              child: CachedNetworkImage(
                imageUrl:
                    '${GlobalVariables.baseUrl}${product.attributes.images.data[0].attributes.url}',
                imageBuilder: (context, imageProvider) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: 320,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: imageProvider,
                    ),
                  ),
                ),
                progressIndicatorBuilder: (_, __, progress) => SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 320,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                ),
                errorWidget: (context, _, __) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: 320,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                  ),
                  child: const Icon(Icons.broken_image, size: 62),
                ),
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
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border_rounded),
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
                          Text(
                              product.attributes.category.data.attributes.name),
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
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.5,
              color: Colors.grey,
            ),
          ),
        ),
        child: Container(
          height: 42,
          margin: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              final cartItem = CartModel(
                id: product.id,
                name: product.attributes.name,
                price: product.attributes.price,
                image: product.attributes.images.data[0].attributes.url,
              );

              context.read<CartBloc>().add(AddCartEvent(cartItem));
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_shopping_cart_sharp,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text('Tambah ke Keranjang'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
