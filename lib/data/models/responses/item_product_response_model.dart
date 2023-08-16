import 'package:beliyuk/data/models/meta_model.dart';
import 'package:beliyuk/data/models/product_model.dart';

class ItemProductResponseModel {
  final ProductModel data;
  final MetaModel? meta;

  ItemProductResponseModel({
    required this.data,
    this.meta,
  });

  factory ItemProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ItemProductResponseModel(
      data: ProductModel.fromJson(json['data'] as Map<String, dynamic>),
      meta: json['meta'] != null
          ? MetaModel.fromJson(json['meta'] as Map<String, dynamic>)
          : null,
    );
  }
}
