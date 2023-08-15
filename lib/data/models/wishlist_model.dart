import 'package:equatable/equatable.dart';

class WishlistModel extends Equatable {
  final int id;
  final WishlistAttributes attributes;

  const WishlistModel({
    required this.id,
    required this.attributes,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        id: json['id'],
        attributes: WishlistAttributes.fromJson(json['attributes']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'attributes': attributes.toJson(),
      };

  @override
  List<Object> get props => [id, attributes];
}

class WishlistAttributes extends Equatable {
  final String name;
  final int price;
  final String image;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final int productId;

  const WishlistAttributes({
    required this.name,
    required this.price,
    required this.image,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.productId,
  });

  factory WishlistAttributes.fromJson(Map<String, dynamic> json) =>
      WishlistAttributes(
        name: json['name'],
        price: json['price'],
        image: json['image'],
        userId: json['userId'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        publishedAt: DateTime.parse(json['publishedAt']),
        productId: json['productId'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'image': image,
        'userId': userId,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'publishedAt': publishedAt.toIso8601String(),
        'productId': productId,
      };

  @override
  List<Object> get props {
    return [
      name,
      price,
      image,
      userId,
      createdAt,
      updatedAt,
      publishedAt,
      productId,
    ];
  }
}
