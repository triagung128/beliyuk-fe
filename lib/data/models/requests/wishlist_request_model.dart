class WishlistRequestModel {
  final int productId;
  final String name;
  final int price;
  final String image;
  final int? userId;

  const WishlistRequestModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    this.userId,
  });

  Map<String, Map<String, dynamic>> toJson() => {
        'data': {
          'productId': productId,
          'name': name,
          'price': price,
          'image': image,
          'userId': userId,
        },
      };

  WishlistRequestModel copyWith({
    int? productId,
    String? name,
    int? price,
    String? image,
    int? userId,
  }) {
    return WishlistRequestModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      userId: userId ?? this.userId,
    );
  }
}
