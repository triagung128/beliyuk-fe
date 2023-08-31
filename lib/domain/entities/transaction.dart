import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final int? id;
  final int userId;
  final List<ProductTransaction> items;
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

  const Transaction({
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
}

class ProductTransaction extends Equatable {
  final int id;
  final String name;
  final String image;
  final int price;
  final int weight;
  final int qty;

  const ProductTransaction({
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
}
