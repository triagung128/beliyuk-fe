import 'package:equatable/equatable.dart';

import 'package:beliyuk/data/models/category_model.dart';

class CategoryListResponseModel extends Equatable {
  final List<CategoryModel> categories;

  const CategoryListResponseModel({
    required this.categories,
  });

  factory CategoryListResponseModel.fromJson(Map<String, dynamic> json) =>
      CategoryListResponseModel(
        categories: List<CategoryModel>.from(
            json['data'].map((category) => CategoryModel.fromJson(category))),
      );

  Map<String, dynamic> toJson() => {
        'data':
            List<dynamic>.from(categories.map((category) => category.toJson())),
      };

  @override
  List<Object> get props => [categories];
}
