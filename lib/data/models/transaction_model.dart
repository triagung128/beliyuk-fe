import 'package:equatable/equatable.dart';

import 'package:beliyuk/domain/entities/transaction.dart';

class TransactionModel extends Equatable {
  final int? id;
  final int userId;
  final List<ProductTransactionModel> items;
  final int totalProductPrice;
  final String shippingAddress;
  final String courierName;
  final int totalShippingCost;
  final String status;
  final String shippingName;
  final String shippingPhoneNumber;
  final int totalWeight;
  final String courierService;
  final int subtotal;
  final String shippingProvince;
  final String shippingCity;
  final DateTime? createdAt;

  const TransactionModel({
    this.id,
    required this.userId,
    required this.items,
    required this.totalProductPrice,
    required this.shippingAddress,
    required this.courierName,
    required this.totalShippingCost,
    required this.status,
    required this.shippingName,
    required this.shippingPhoneNumber,
    required this.totalWeight,
    required this.courierService,
    required this.subtotal,
    required this.shippingProvince,
    required this.shippingCity,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        items,
        totalProductPrice,
        shippingAddress,
        courierName,
        totalShippingCost,
        status,
        shippingName,
        shippingPhoneNumber,
        totalWeight,
        courierService,
        subtotal,
        shippingProvince,
        shippingCity,
        createdAt,
      ];

  Map<String, dynamic> toJson() => {
        'data': {
          'userId': userId,
          'items': items.map((product) => product.toJson()).toList(),
          'totalProductPrice': totalProductPrice,
          'shippingAddress': shippingAddress,
          'courierName': courierName,
          'totalShippingCost': totalShippingCost,
          'status': status,
          'shippingName': shippingName,
          'shippingPhoneNumber': shippingPhoneNumber,
          'totalWeight': totalWeight,
          'courierService': courierService,
          'subtotal': subtotal,
          'shippingProvince': shippingProvince,
          'shippingCity': shippingCity,
        }
      };

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        userId: json['attributes']['userId'],
        items: List<ProductTransactionModel>.from(
          json['attributes']['items'].map<ProductTransactionModel>(
            (x) => ProductTransactionModel.fromJson(x),
          ),
        ),
        totalProductPrice: json['attributes']['totalProductPrice'],
        shippingAddress: json['attributes']['shippingAddress'],
        courierName: json['attributes']['courierName'],
        totalShippingCost: json['attributes']['totalShippingCost'],
        status: json['attributes']['status'],
        shippingName: json['attributes']['shippingName'],
        shippingPhoneNumber: json['attributes']['shippingPhoneNumber'],
        totalWeight: json['attributes']['totalWeight'],
        courierService: json['attributes']['courierService'],
        subtotal: json['attributes']['subtotal'],
        shippingProvince: json['attributes']['shippingProvince'],
        shippingCity: json['attributes']['shippingCity'],
        createdAt: json['attributes']['createdAt'] == null
            ? null
            : DateTime.parse(json['attributes']['createdAt']),
      );

  Transaction toEntity() => Transaction(
        id: id,
        userId: userId,
        items: List<ProductTransaction>.from(
          items.map((product) => product.toEntity()),
        ),
        totalProductPrice: totalProductPrice,
        shippingAddress: shippingAddress,
        courierName: courierName,
        totalShippingCost: totalShippingCost,
        status: status,
        shippingName: shippingName,
        shippingPhoneNumber: shippingPhoneNumber,
        totalWeight: totalWeight,
        courierService: courierService,
        subtotal: subtotal,
        shippingProvince: shippingProvince,
        shippingCity: shippingCity,
        createdAt: createdAt,
      );

  factory TransactionModel.fromEntity(Transaction entity) => TransactionModel(
        userId: entity.userId,
        items: List<ProductTransactionModel>.from(
          entity.items.map((item) => ProductTransactionModel.fromEntity(item)),
        ),
        totalProductPrice: entity.totalProductPrice,
        shippingAddress: entity.shippingAddress,
        courierName: entity.courierName,
        totalShippingCost: entity.totalShippingCost,
        status: entity.status,
        shippingName: entity.shippingName,
        shippingPhoneNumber: entity.shippingPhoneNumber,
        totalWeight: entity.totalWeight,
        courierService: entity.courierService,
        subtotal: entity.subtotal,
        shippingProvince: entity.shippingProvince,
        shippingCity: entity.shippingCity,
      );
}

class ProductTransactionModel extends Equatable {
  final int id;
  final String name;
  final String image;
  final int price;
  final int weight;
  final int qty;

  const ProductTransactionModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.weight,
    required this.qty,
  });

  @override
  List<Object> get props => [
        id,
        name,
        image,
        price,
        weight,
        qty,
      ];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'price': price,
        'weight': weight,
        'qty': qty,
      };

  factory ProductTransactionModel.fromJson(Map<String, dynamic> json) =>
      ProductTransactionModel(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        price: json['price'],
        weight: json['weight'],
        qty: json['qty'],
      );

  ProductTransaction toEntity() => ProductTransaction(
        id: id,
        name: name,
        image: image,
        price: price,
        weight: weight,
        qty: qty,
      );

  factory ProductTransactionModel.fromEntity(ProductTransaction entity) =>
      ProductTransactionModel(
        id: entity.id,
        name: entity.name,
        image: entity.image,
        price: entity.price,
        weight: entity.weight,
        qty: entity.qty,
      );
}
