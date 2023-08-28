import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/presentation/blocs/checkout/checkout_bloc.dart';
import 'package:beliyuk/presentation/pages/checkout/widgets/title_checkout.dart';
import 'package:beliyuk/presentation/pages/input_address/input_address_page.dart';

class CheckoutAddress extends StatelessWidget {
  const CheckoutAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => InputAddressPage(
                  address: state.address,
                  totalWeight: state.totalWeight,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleCheckout(
                  text: 'Alamat Pengiriman',
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<CheckoutBloc, CheckoutState>(
                        builder: (context, state) {
                          if (state.address != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(state.address!.name),
                                    const Text(' | '),
                                    Text(state.address!.phoneNumber),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(state.address!.address),
                                const SizedBox(height: 4),
                                Text(
                                  '${state.address!.city.type.toUpperCase()} ${state.address!.city.cityName.toUpperCase()}, ${state.address!.province.province.toUpperCase()}',
                                ),
                              ],
                            );
                          }

                          return const Text(
                            'Mohon lengkapi alamat pengiriman terlebih dahulu',
                          );
                        },
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
