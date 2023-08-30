import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/int_extensions.dart';
import 'package:beliyuk/presentation/blocs/checkout/checkout_bloc.dart';
import 'package:beliyuk/presentation/pages/checkout/widgets/checkout_address.dart';
import 'package:beliyuk/presentation/pages/checkout/widgets/checkout_courier.dart';
import 'package:beliyuk/presentation/pages/checkout/widgets/checkout_payment_detail.dart';
import 'package:beliyuk/presentation/pages/checkout/widgets/checkout_product_items.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    final checkoutState = context.read<CheckoutBloc>().state;
    if (checkoutState.address != null) {
      context.read<CheckoutBloc>().add(
            DoGetCourier(
              destination: checkoutState.address!.city.cityId,
              weight: checkoutState.totalWeight,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CheckoutAddress(),
              const CheckoutProductItems(),
              CheckoutCourier(
                scaffoldMessengerKey: _scaffoldMessengerKey,
              ),
              const CheckoutPaymentDetail(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 0.2,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Total Pembayaran :'),
                    const SizedBox(height: 2),
                    BlocBuilder<CheckoutBloc, CheckoutState>(
                      builder: (_, state) {
                        return Text(
                          state.subtotal.intToFormatRupiah,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  return SizedBox(
                    width: 130,
                    child: Material(
                      color: state.address != null &&
                              state.selectedCourierService != null
                          ? Colors.blue
                          : Colors.grey,
                      child: InkWell(
                        onTap: state.address != null &&
                                state.selectedCourierService != null
                            ? () {}
                            : null,
                        child: const Center(
                          child: Text(
                            'Buat Pesanan',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
