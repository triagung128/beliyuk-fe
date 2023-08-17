import 'package:equatable/equatable.dart';

class Wishlist extends Equatable {
  final int? id;
  final int userId;
  final int productId;
  final String name;
  final int price;
  final String image;

  const Wishlist({
    this.id,
    required this.userId,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      productId,
      name,
      price,
      image,
    ];
  }
}
