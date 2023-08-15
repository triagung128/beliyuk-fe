import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/bloc/cart/cart_bloc.dart';
import 'package:fic6_fe_beliyuk/bloc/detail_product/detail_product_bloc.dart';
import 'package:fic6_fe_beliyuk/common/enum_state.dart';
import 'package:fic6_fe_beliyuk/common/global_variables.dart';
import 'package:fic6_fe_beliyuk/common/int_extensions.dart';
import 'package:fic6_fe_beliyuk/data/models/cart_model.dart';
import 'package:fic6_fe_beliyuk/presentation/common_widgets/custom_appbar_with_cart_icon.dart';

class DetailProductPage extends StatefulWidget {
  final int productId;

  const DetailProductPage({
    super.key,
    required this.productId,
  });

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<DetailProductBloc>()
        .add(FetchDetailProductEvent(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailProductBloc, DetailProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBarWithCartIcon(
            centerTitle: true,
            title: Text('Detail Produk'),
          ),
          body: BlocBuilder<DetailProductBloc, DetailProductState>(
            builder: (context, state) {
              if (state.state == RequestState.loading) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              }

              if (state.state == RequestState.loaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            '${GlobalVariables.baseUrl}${state.product!.attributes.images.data[0].attributes.url}',
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
                                  state.product!.attributes.price
                                      .intToFormatRupiah,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite_border_rounded,
                                    color: Colors.pink,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.product!.attributes.name,
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
                                    Text(state.product!.attributes.weight
                                        .convertUnitWeight),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    const Text('Kategori'),
                                    Text(state.product!.attributes.category.data
                                        .attributes.name),
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
                            Text(state.product!.attributes.description),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (state.state == RequestState.error) {
                return Center(
                  child: Text(state.message),
                );
              }

              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: state.state == RequestState.loaded
              ? Container(
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
                          id: state.product!.id,
                          name: state.product!.attributes.name,
                          price: state.product!.attributes.price,
                          image: state.product!.attributes.images.data[0]
                              .attributes.url,
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
                )
              : null,
        );
      },
    );
  }
}
