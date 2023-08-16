import 'package:equatable/equatable.dart';
import 'package:beliyuk/data/models/category_model.dart';
import 'package:beliyuk/data/models/meta_model.dart';

class ListCategoryResponseModel extends Equatable {
  final List<CategoryModel> data;
  final MetaModel meta;

  const ListCategoryResponseModel({
    required this.data,
    required this.meta,
  });

  factory ListCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      ListCategoryResponseModel(
        data: List<CategoryModel>.from(
            json['data'].map((category) => CategoryModel.fromJson(category))),
        meta: MetaModel.fromJson(json['meta']),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((category) => category.toJson())),
        'meta': meta.toJson(),
      };

  @override
  List<Object> get props => [data, meta];
}
