import 'package:equatable/equatable.dart';
import 'package:beliyuk/data/models/image_model.dart';

class BannerModel extends Equatable {
  final int id;
  final BannerAttribute attributes;

  const BannerModel({
    required this.id,
    required this.attributes,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json['id'],
        attributes: BannerAttribute.fromJson(json['attributes']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'attributes': attributes.toJson(),
      };

  @override
  List<Object> get props => [id, attributes];
}

class BannerAttribute extends Equatable {
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final BannerImage image;

  const BannerAttribute({
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.image,
  });

  factory BannerAttribute.fromJson(Map<String, dynamic> json) =>
      BannerAttribute(
        name: json['name'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        publishedAt: DateTime.parse(json['publishedAt']),
        image: BannerImage.fromJson(json['image']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'publishedAt': publishedAt.toIso8601String(),
        'image': image.toJson(),
      };

  @override
  List<Object> get props => [
        name,
        createdAt,
        updatedAt,
        publishedAt,
        image,
      ];
}

class BannerImage extends Equatable {
  final ImageModel data;

  const BannerImage({
    required this.data,
  });

  factory BannerImage.fromJson(Map<String, dynamic> json) => BannerImage(
        data: ImageModel.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
      };

  @override
  List<Object> get props => [data];
}
