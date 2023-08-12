import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/bloc/cart/cart_bloc.dart';
import 'package:fic6_fe_beliyuk/common/global_variables.dart';
import 'package:fic6_fe_beliyuk/common/int_extensions.dart';
import 'package:fic6_fe_beliyuk/data/models/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Saya'),
        elevation: 0,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            if (state.items.isNotEmpty) {
              return ListView.builder(
                itemCount: state.items.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final CartModel cart = state.items[index];
                  return ItemCart(cart: cart, index: index);
                },
              );
            } else {
              return const Center(
                child: Text('Keranjang Anda kosong !'),
              );
            }
          }

          return const Center(
            child: Text('Keranjang Anda kosong !'),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 116,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.5,
              color: Colors.grey,
            ),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Belanja'),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state is CartLoaded) {
                        return Text(state.totalPrice.intToFormatRupiah);
                      }
                      return const Text('0');
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(16),
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    if (state.items.isNotEmpty) {
                      return ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward, size: 20),
                        label: const Text(
                          'Lanjut Checkout',
                        ),
                      );
                    } else {
                      return ElevatedButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.arrow_forward, size: 20),
                        label: const Text(
                          'Lanjut Checkout',
                        ),
                      );
                    }
                  }
                  return ElevatedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.arrow_forward, size: 20),
                    label: const Text(
                      'Lanjut Checkout',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCart extends StatelessWidget {
  const ItemCart({
    super.key,
    required this.cart,
    required this.index,
  });

  final CartModel cart;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: index == 0 ? 0 : 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: '${GlobalVariables.baseUrl}${cart.image}',
            imageBuilder: (_, imageProvider) => Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(image: imageProvider),
              ),
            ),
            progressIndicatorBuilder: (_, __, progress) => SizedBox(
              height: 110,
              width: 110,
              child: Center(
                child: CircularProgressIndicator(value: progress.progress),
              ),
            ),
            errorWidget: (_, __, ___) => Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: Colors.grey[350],
              ),
              child: const Icon(Icons.broken_image),
            ),
          ),
          Expanded(
            child: Container(
              height: 110,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cart.name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cart.price.intToFormatRupiah,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          context
                              .read<CartBloc>()
                              .add(RemoveCartEvent(cart.id));
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.delete_outline),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: cart.quantity == 1
                                  ? null
                                  : () {
                                      context
                                          .read<CartBloc>()
                                          .add(ReduceQuantityEvent(cart));
                                    },
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: 20,
                                  color: cart.quantity == 1
                                      ? Colors.grey
                                      : Colors.blue,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                '${cart.quantity}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                context
                                    .read<CartBloc>()
                                    .add(AddQuantityEvent(cart));
                              },
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
