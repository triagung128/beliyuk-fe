import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/presentation/blocs/checkout/checkout_bloc.dart';
import 'package:beliyuk/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:beliyuk/presentation/pages/checkout/widgets/checkout_address.dart';
import 'package:beliyuk/presentation/pages/checkout/widgets/checkout_courier.dart';
import 'package:beliyuk/presentation/pages/checkout/widgets/checkout_create_transaction_button.dart';
import 'package:beliyuk/presentation/pages/checkout/widgets/checkout_payment_detail.dart';
import 'package:beliyuk/presentation/pages/checkout/widgets/checkout_product_items.dart';
import 'package:beliyuk/presentation/pages/payment/payment_page.dart';

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
        body: BlocListener<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is TransactionCreateSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentPage(url: state.result.redirectUrl),
                ),
              );
            }

            if (state is TransactionError) {
              _scaffoldMessengerKey.currentState!
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
            }
          },
          child: SingleChildScrollView(
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
        ),
        bottomNavigationBar: const CheckoutCreateTransactionButton(),
      ),
    );
  }
}
