import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/int_extensions.dart';
import 'package:beliyuk/domain/entities/cart.dart';
import 'package:beliyuk/presentation/blocs/auth/auth_bloc.dart';
import 'package:beliyuk/presentation/blocs/cart/cart_bloc.dart';
import 'package:beliyuk/presentation/blocs/checkout/checkout_bloc.dart';
import 'package:beliyuk/presentation/pages/auth/auth_page.dart';
import 'package:beliyuk/presentation/pages/cart/widgets/button_checkout.dart';
import 'package:beliyuk/presentation/pages/cart/widgets/item_cart.dart';
import 'package:beliyuk/presentation/pages/checkout/checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Saya'),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            if (state.items.isNotEmpty) {
              return ListView.builder(
                itemCount: state.items.length,
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                itemBuilder: (context, index) {
                  return ItemCart(
                    cart: state.items[index],
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/empty-cart.png',
                      height: 120,
                      width: 120,
                    ),
                    const SizedBox(height: 16),
                    const Text('Keranjang Anda masih kosong'),
                  ],
                ),
              );
            }
          }

          return const SizedBox();
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
              height: 48,
              margin: const EdgeInsets.all(16),
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded && state.items.isNotEmpty) {
                    final List<Cart> cartItems = state.items;
                    final int totalPrice = state.totalPrice;
                    final int totalWeight = state.totalWeight;

                    return BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return ButtonCheckout(
                          onPressed: () {
                            if (state.user != null) {
                              context.read<CheckoutBloc>().add(
                                    DoSetCartItems(
                                      carts: cartItems,
                                      totalPriceProduct: totalPrice,
                                      totalWeight: totalWeight,
                                    ),
                                  );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CheckoutPage(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AuthPage(),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  }

                  return const ButtonCheckout(onPressed: null);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
