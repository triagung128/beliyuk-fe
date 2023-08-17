import 'package:equatable/equatable.dart';

import 'package:beliyuk/domain/entities/banner.dart';

class BannerModel extends Equatable {
  final int id;
  final String name;
  final String image;

  const BannerModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json['id'],
        name: json['attributes']['name'],
        image: json['attributes']['image']['data']['attributes']['url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'attributes': {
          'name': name,
          'image': {
            'data': {
              'attributes': {
                'url': image,
              },
            },
          },
        },
      };

  Banner toEntity() => Banner(
        id: id,
        name: name,
        image: image,
      );

  @override
  List<Object> get props => [id, name, image];
}
