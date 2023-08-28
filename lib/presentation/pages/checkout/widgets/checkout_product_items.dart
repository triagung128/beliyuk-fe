import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/constants.dart';
import 'package:beliyuk/common/int_extensions.dart';
import 'package:beliyuk/domain/entities/cart.dart';
import 'package:beliyuk/presentation/blocs/checkout/checkout_bloc.dart';
import 'package:beliyuk/presentation/pages/checkout/widgets/title_checkout.dart';

class CheckoutProductItems extends StatelessWidget {
  const CheckoutProductItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleCheckout(
            text: 'List Produk',
            icon: Icons.shopping_basket,
          ),
          const SizedBox(height: 10),
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              return ListView.separated(
                separatorBuilder: (_, __) => const Divider(
                  thickness: 0.5,
                  color: Colors.grey,
                ),
                shrinkWrap: true,
                primary: false,
                itemCount: state.carts.length,
                itemBuilder: (context, index) {
                  final Cart item = state.carts[index];
                  return ItemProductCheckout(item: item);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ItemProductCheckout extends StatelessWidget {
  const ItemProductCheckout({
    super.key,
    required this.item,
  });

  final Cart item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Image.network(
            '${Urls.baseUrl}${item.image}',
            height: 100,
            width: 100,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.price.intToFormatRupiah,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('x ${item.quantity}'),
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
