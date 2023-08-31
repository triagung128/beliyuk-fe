import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/domain/entities/address.dart';
import 'package:beliyuk/domain/entities/cart.dart';
import 'package:beliyuk/domain/entities/courier.dart';
import 'package:beliyuk/domain/entities/midtrans.dart';
import 'package:beliyuk/domain/entities/transaction.dart';
import 'package:beliyuk/domain/usecases/auth/get_auth.dart';
import 'package:beliyuk/domain/usecases/transaction/create_transaction.dart';
import 'package:beliyuk/domain/usecases/transaction/get_all_transactions.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetAuth getAuth;
  final GetAllTransactions getAllTransactions;
  final CreateTransaction createTransaction;

  TransactionBloc({
    required this.getAuth,
    required this.getAllTransactions,
    required this.createTransaction,
  }) : super(TransactionInitial()) {
    on<DoGetAllTransactionsEvent>((event, emit) async {
      emit(TransactionLoading());

      final user = await getAuth.execute();

      if (user != null) {
        final result = await getAllTransactions.execute(
          userId: user.id,
          token: user.token,
        );

        result.fold(
          (failure) => emit(TransactionError(failure.message)),
          (data) => emit(TransactionLoaded(data)),
        );
      } else {
        emit(const TransactionError('Anda belum login!'));
      }
    });

    on<DoCreateTransactionEvent>((event, emit) async {
      emit(TransactionLoading());

      final user = await getAuth.execute();

      if (user != null) {
        final request = Transaction(
          userId: user.id,
          items: List<ProductTransaction>.from(
            event.carts.map(
              (cart) => ProductTransaction(
                id: cart.id,
                name: cart.name,
                image: cart.image,
                price: cart.price,
                weight: cart.weight,
                qty: cart.quantity,
              ),
            ),
          ),
          totalProductPrice: event.totalPriceProduct,
          shippingAddress: event.address.address,
          courierName: event.courierName,
          totalShippingCost: event.courierService.cost.value,
          status: 'waitingPayment',
          shippingName: event.address.name,
          shippingPhoneNumber: event.address.phoneNumber,
          totalWeight: event.totalWeight,
          courierService: event.courierService.service,
          subtotal: event.subtotal,
          shippingProvince: event.address.province.province,
          shippingCity: event.address.city.cityName,
        );

        final result = await createTransaction.execute(
          data: request,
          token: user.token,
        );

        result.fold(
          (failure) => emit(TransactionError(failure.message)),
          (data) => emit(TransactionCreateSuccess(data)),
        );
      } else {
        emit(const TransactionError('Anda belum login!'));
      }
    });
  }
}
