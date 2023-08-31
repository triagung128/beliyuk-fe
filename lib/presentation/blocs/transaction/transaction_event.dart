part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

final class DoGetAllTransactionsEvent extends TransactionEvent {}

final class DoCreateTransactionEvent extends TransactionEvent {
  final Address address;
  final List<Cart> carts;
  final String courierName;
  final CourierService courierService;
  final int totalPriceProduct;
  final int totalWeight;
  final int subtotal;

  const DoCreateTransactionEvent({
    required this.address,
    required this.carts,
    required this.courierName,
    required this.courierService,
    required this.totalPriceProduct,
    required this.totalWeight,
    required this.subtotal,
  });

  @override
  List<Object> get props => [
        address,
        carts,
        courierName,
        courierService,
        totalPriceProduct,
        totalWeight,
        subtotal,
      ];
}
