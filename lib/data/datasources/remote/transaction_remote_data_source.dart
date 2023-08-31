import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:beliyuk/common/constants.dart';
import 'package:beliyuk/common/exception.dart';
import 'package:beliyuk/data/models/midtrans_model.dart';
import 'package:beliyuk/data/models/responses/transaction_list_response_model.dart';
import 'package:beliyuk/data/models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<MidtransModel> createTransaction({
    required TransactionModel data,
    required String token,
  });
  Future<List<TransactionModel>> getAllTransactions({
    required int userId,
    required String token,
  });
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final http.Client client;

  TransactionRemoteDataSourceImpl({required this.client});

  @override
  Future<MidtransModel> createTransaction({
    required TransactionModel data,
    required String token,
  }) async {
    final response = await client.post(
      Uri.parse(Urls.createOrder),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data.toJson()),
    );

    if (response.statusCode == 200) {
      return MidtransModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TransactionModel>> getAllTransactions({
    required int userId,
    required String token,
  }) async {
    final response = await client.get(
      Uri.parse(Urls.getAllOrders(userId)),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return TransactionListResponseModel.fromJson(json.decode(response.body))
          .data;
    } else {
      throw ServerException();
    }
  }
}
