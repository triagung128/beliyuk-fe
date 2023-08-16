import 'package:equatable/equatable.dart';
import 'package:beliyuk/data/models/meta_model.dart';
import 'package:beliyuk/data/models/product_model.dart';

class ListProductResponseModel extends Equatable {
  final List<ProductModel> data;
  final MetaModel meta;

  const ListProductResponseModel({
    required this.data,
    required this.meta,
  });

  factory ListProductResponseModel.fromJson(Map<String, dynamic> json) =>
      ListProductResponseModel(
        data: List<ProductModel>.from(
            json['data'].map((product) => ProductModel.fromJson(product))),
        meta: MetaModel.fromJson(json['meta']),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((product) => product.toJson())),
        'meta': meta.toJson(),
      };

  @override
  List<Object> get props => [data, meta];
}
