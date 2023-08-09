import 'package:fic6_fe_beliyuk/data/models/image_model.dart';
import 'package:fic6_fe_beliyuk/data/models/meta_model.dart';

class ListBannerResponseModel {
  final List<Banner> data;
  final MetaModel meta;

  ListBannerResponseModel({
    required this.data,
    required this.meta,
  });

  factory ListBannerResponseModel.fromJson(Map<String, dynamic> json) =>
      ListBannerResponseModel(
        data: List<Banner>.from(
            json['data'].map((banner) => Banner.fromJson(banner))),
        meta: MetaModel.fromJson(json['meta']),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((banner) => banner.toJson())),
        'meta': meta.toJson(),
      };
}

class Banner {
  final int id;
  final BannerAttribute attributes;

  Banner({
    required this.id,
    required this.attributes,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json['id'],
        attributes: BannerAttribute.fromJson(json['attributes']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'attributes': attributes.toJson(),
      };
}

class BannerAttribute {
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final BannerImage image;

  BannerAttribute({
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
}

class BannerImage {
  ImageModel data;

  BannerImage({
    required this.data,
  });

  factory BannerImage.fromJson(Map<String, dynamic> json) => BannerImage(
        data: ImageModel.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
      };
}
