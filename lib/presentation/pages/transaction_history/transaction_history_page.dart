import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:beliyuk/presentation/common_widgets/custom_appbar_with_cart_icon.dart';
import 'package:beliyuk/presentation/pages/transaction_history/widgets/item_transaction.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(DoGetAllTransactionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWithCartIcon(
        automaticallyImplyLeading: false,
        title: Text('Riwayat Transaksi'),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TransactionLoaded) {
            if (state.data.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(
                    const Duration(seconds: 1),
                    () {
                      context
                          .read<TransactionBloc>()
                          .add(DoGetAllTransactionsEvent());
                    },
                  );
                },
                child: ListView.builder(
                  key: const PageStorageKey<String>('transaction'),
                  itemCount: state.data.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final item = state.data[index];
                    return ItemTransaction(item: item);
                  },
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/empty-transaction.png',
                      height: 120,
                      width: 120,
                    ),
                    const SizedBox(height: 16),
                    const Text('Anda belum memiliki transaksi'),
                  ],
                ),
              );
            }
          }

          if (state is TransactionError) {
            return Center(
              child: Text(state.message),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
