import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final int id;
  final String name;
  final int price;
  final String image;
  final int quantity;

  const Cart({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 0,
  });

  @override
  List<Object> get props => [
        id,
        name,
        price,
        image,
        quantity,
      ];
}
