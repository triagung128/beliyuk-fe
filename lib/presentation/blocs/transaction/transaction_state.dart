part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

final class TransactionInitial extends TransactionState {}

final class TransactionLoading extends TransactionState {}

final class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);

  @override
  List<Object> get props => [message];
}

final class TransactionLoaded extends TransactionState {
  final List<Transaction> data;

  const TransactionLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class TransactionCreateSuccess extends TransactionState {
  final Midtrans result;

  const TransactionCreateSuccess(this.result);

  @override
  List<Object> get props => [result];
}
