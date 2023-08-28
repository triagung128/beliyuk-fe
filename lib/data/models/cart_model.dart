import 'package:equatable/equatable.dart';

import 'package:beliyuk/domain/entities/cart.dart';

class CartModel extends Equatable {
  final int id;
  final String name;
  final int price;
  final String image;
  final int weight;
  final int quantity;

  const CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.weight,
    this.quantity = 0,
  });

  @override
  List<Object> get props => [
        id,
        name,
        price,
        image,
        weight,
        quantity,
      ];

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'image': image,
        'weight': weight,
        'quantity': quantity,
      };

  Map<String, dynamic> addQuantityToMap() => {
        'quantity': quantity + 1,
      };

  Map<String, dynamic> reduceQuantityToMap() => {
        'quantity': quantity - 1,
      };

  factory CartModel.fromMap(Map<String, dynamic> map) => CartModel(
        id: map['id'],
        name: map['name'],
        price: map['price'],
        image: map['image'],
        weight: map['weight'],
        quantity: map['quantity'],
      );

  Cart toEntity() => Cart(
        id: id,
        name: name,
        price: price,
        image: image,
        weight: weight,
        quantity: quantity,
      );

  factory CartModel.fromEntity(Cart cart) => CartModel(
        id: cart.id,
        name: cart.name,
        price: cart.price,
        image: cart.image,
        weight: cart.weight,
        quantity: cart.quantity == 0 ? 1 : cart.quantity,
      );
}
