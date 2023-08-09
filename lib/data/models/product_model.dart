import 'package:fic6_fe_beliyuk/data/models/category_model.dart';
import 'package:fic6_fe_beliyuk/data/models/image_model.dart';

class ProductModel {
  final int id;
  final ProductAttributes attributes;

  ProductModel({
    required this.id,
    required this.attributes,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        attributes: ProductAttributes.fromJson(json['attributes']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'attributes': attributes.toJson(),
      };
}

class ProductAttributes {
  final String name;
  final String description;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final int weight;
  final ProductCategory category;
  final ProductImages images;

  ProductAttributes({
    required this.name,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.weight,
    required this.category,
    required this.images,
  });

  factory ProductAttributes.fromJson(Map<String, dynamic> json) =>
      ProductAttributes(
        name: json['name'],
        description: json['description'],
        price: json['price'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        publishedAt: DateTime.parse(json['publishedAt']),
        weight: json['weight'],
        category: ProductCategory.fromJson(json['category']),
        images: ProductImages.fromJson(json['images']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'price': price,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'publishedAt': publishedAt.toIso8601String(),
        'weight': weight,
        'category': category.toJson(),
        'images': images.toJson(),
      };
}

class ProductCategory {
  final CategoryModel data;

  ProductCategory({
    required this.data,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        data: CategoryModel.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
      };
}

class ProductImages {
  final List<ImageModel> data;

  ProductImages({
    required this.data,
  });

  factory ProductImages.fromJson(Map<String, dynamic> json) => ProductImages(
        data: List<ImageModel>.from(
            json['data'].map((image) => ImageModel.fromJson(image))),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((image) => image.toJson())),
      };
}
