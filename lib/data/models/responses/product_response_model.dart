import 'package:equatable/equatable.dart';

import 'package:beliyuk/data/models/product_model.dart';

class ProductResponseModel extends Equatable {
  final ProductModel product;

  const ProductResponseModel({
    required this.product,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductResponseModel(
      product: ProductModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object> get props => [product];
}
