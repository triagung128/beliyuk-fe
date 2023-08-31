import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/int_extensions.dart';
import 'package:beliyuk/presentation/blocs/cart/cart_bloc.dart';
import 'package:beliyuk/presentation/blocs/checkout/checkout_bloc.dart';
import 'package:beliyuk/presentation/blocs/transaction/transaction_bloc.dart';

class CheckoutCreateTransactionButton extends StatelessWidget {
  const CheckoutCreateTransactionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _buildText(),
          const SizedBox(width: 16),
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionLoading) return _buildLoading();
              return _buildButton();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const SizedBox(
      width: 130,
      child: Material(
        color: Colors.grey,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        return SizedBox(
          width: 130,
          child: Material(
            color: state.address != null && state.selectedCourierService != null
                ? Colors.blue
                : Colors.grey,
            child: InkWell(
              onTap:
                  state.address != null && state.selectedCourierService != null
                      ? () {
                          context.read<CartBloc>().add(DeleteAllCartEvent());
                          context.read<TransactionBloc>().add(
                                DoCreateTransactionEvent(
                                  address: state.address!,
                                  carts: state.carts,
                                  courierName: state.courier!.name,
                                  courierService: state.selectedCourierService!,
                                  totalPriceProduct: state.totalPriceProduct,
                                  totalWeight: state.totalWeight,
                                  subtotal: state.subtotal,
                                ),
                              );
                        }
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
    );
  }

  Widget _buildText() {
    return Expanded(
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
    );
  }
}
