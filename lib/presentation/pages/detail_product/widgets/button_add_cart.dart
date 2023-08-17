import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/domain/entities/cart.dart';
import 'package:beliyuk/domain/entities/product.dart';
import 'package:beliyuk/presentation/blocs/cart/cart_bloc.dart';

class ButtonAddCart extends StatelessWidget {
  const ButtonAddCart({
    super.key,
    required this.product,
  });

  final Product product;

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
            final Cart cartItem = Cart(
              id: product.id,
              name: product.name,
              price: product.price,
              image: product.images[0],
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
