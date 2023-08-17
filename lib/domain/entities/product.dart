import 'package:equatable/equatable.dart';

import 'package:beliyuk/domain/entities/category.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String description;
  final int price;
  final int weight;
  final Category category;
  final List<String> images;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.weight,
    required this.category,
    required this.images,
  });

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
