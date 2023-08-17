import 'package:equatable/equatable.dart';

import 'package:beliyuk/domain/entities/category.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String logo;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        name: json['attributes']['name'],
        logo: json['attributes']['logo']['data']['attributes']['url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'attributes': {
          'name': name,
          'logo': {
            'data': {
              'attributes': {
                'url': logo,
              },
            },
          },
        },
      };

  Category toEntity() => Category(
        id: id,
        name: name,
        logo: logo,
      );

  @override
  List<Object> get props => [id, name, logo];
}
