import 'package:equatable/equatable.dart';

import 'package:beliyuk/domain/entities/wishlist.dart';

class WishlistModel extends Equatable {
  final int? id;
  final int userId;
  final int productId;
  final String name;
  final int price;
  final int weight;
  final String image;

  const WishlistModel({
    this.id,
    required this.userId,
    required this.productId,
    required this.name,
    required this.price,
    required this.weight,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        'data': {
          'userId': userId,
          'productId': productId,
          'name': name,
          'price': price,
          'weight': weight,
          'image': image,
        },
      };

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        id: json['id'],
        userId: json['attributes']['userId'],
        productId: json['attributes']['productId'],
        name: json['attributes']['name'],
        price: json['attributes']['price'],
        weight: json['attributes']['weight'],
        image: json['attributes']['image'],
      );

  Wishlist toEntity() => Wishlist(
        id: id,
        userId: userId,
        productId: productId,
        name: name,
        price: price,
        weight: weight,
        image: image,
      );

  factory WishlistModel.fromEntity(Wishlist wishlist) => WishlistModel(
        userId: wishlist.userId,
        productId: wishlist.productId,
        name: wishlist.name,
        price: wishlist.price,
        weight: wishlist.weight,
        image: wishlist.image,
      );

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      productId,
      name,
      price,
      weight,
      image,
    ];
  }
}
