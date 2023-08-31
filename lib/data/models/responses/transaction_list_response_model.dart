import 'package:equatable/equatable.dart';

import 'package:beliyuk/data/models/transaction_model.dart';

class TransactionListResponseModel extends Equatable {
  final List<TransactionModel> data;

  const TransactionListResponseModel({
    required this.data,
  });

  @override
  List<Object> get props => [data];

  factory TransactionListResponseModel.fromJson(Map<String, dynamic> json) =>
      TransactionListResponseModel(
        data: List<TransactionModel>.from(
          json['data'].map<TransactionModel>(
            (x) => TransactionModel.fromJson(x),
          ),
        ),
      );
}
