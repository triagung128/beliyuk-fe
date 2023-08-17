import 'package:equatable/equatable.dart';

import 'package:beliyuk/data/models/product_model.dart';

class ProductListResponseModel extends Equatable {
  final List<ProductModel> products;

  const ProductListResponseModel({
    required this.products,
  });

  factory ProductListResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductListResponseModel(
        products: List<ProductModel>.from(
            json['data'].map((product) => ProductModel.fromJson(product))),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(products.map((product) => product.toJson())),
      };

  @override
  List<Object> get props => [products];
}
