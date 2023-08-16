import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/bloc/cart/cart_bloc.dart';
import 'package:beliyuk/data/models/cart_model.dart';
import 'package:beliyuk/data/models/product_model.dart';

class ButtonAddCart extends StatelessWidget {
  const ButtonAddCart({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
