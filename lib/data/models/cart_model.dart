import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final int id;
  final String name;
  final int price;
  final String image;
  final int quantity;

  const CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      price,
      image,
      quantity,
    ];
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'image': image,
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
        quantity: map['quantity'],
      );
}
