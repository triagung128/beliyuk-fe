import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/constants.dart';
import 'package:beliyuk/common/int_extensions.dart';
import 'package:beliyuk/domain/entities/cart.dart';
import 'package:beliyuk/presentation/blocs/cart/cart_bloc.dart';

class ItemCart extends StatelessWidget {
  const ItemCart({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: '${Urls.baseUrl}${cart.image}',
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
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cart.price.intToFormatRupiah,
                        style: const TextStyle(
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
