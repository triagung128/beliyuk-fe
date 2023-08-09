import 'package:fic6_fe_beliyuk/data/models/image_model.dart';

class CategoryModel {
  int id;
  CategoryAttributes attributes;

  CategoryModel({
    required this.id,
    required this.attributes,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        attributes: CategoryAttributes.fromJson(json['attributes']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'attributes': attributes.toJson(),
      };
}

class CategoryAttributes {
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime publishedAt;
  Logo logo;

  CategoryAttributes({
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.logo,
  });

  factory CategoryAttributes.fromJson(Map<String, dynamic> json) =>
      CategoryAttributes(
        name: json['name'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        publishedAt: DateTime.parse(json['publishedAt']),
        logo: Logo.fromJson(json['logo']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'publishedAt': publishedAt.toIso8601String(),
        'logo': logo.toJson(),
      };
}

class Logo {
  ImageModel data;

  Logo({
    required this.data,
  });

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        data: ImageModel.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
      };
}
