import 'package:equatable/equatable.dart';

import 'package:beliyuk/data/models/category_model.dart';
import 'package:beliyuk/domain/entities/product.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final int price;
  final int weight;
  final CategoryModel category;
  final List<String> images;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.weight,
    required this.category,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['attributes']['name'],
        description: json['attributes']['description'],
        price: json['attributes']['price'],
        weight: json['attributes']['weight'],
        category:
            CategoryModel.fromJson(json['attributes']['category']['data']),
        images: List<String>.from(json['attributes']['images']['data']
            .map((image) => image['attributes']['url'])),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'attributes': {
          'name': name,
          'description': description,
          'price': price,
          'weight': weight,
          'category': {
            'data': category.toJson(),
          },
          'images': {
            'data': [
              List<dynamic>.from(
                images.map(
                  (image) => {
                    'attributes': {
                      'url': {
                        image,
                      },
                    },
                  },
                ),
              ),
            ],
          },
        },
      };

  Product toEntity() => Product(
        id: id,
        name: name,
        description: description,
        price: price,
        weight: weight,
        category: category.toEntity(),
        images: images,
      );

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      price,
      weight,
      category,
      images,
    ];
  }
}
