import 'package:equatable/equatable.dart';

import 'package:beliyuk/domain/entities/address.dart';

class ProvinceModel extends Equatable {
  final String provinceId;
  final String province;

  const ProvinceModel({
    required this.provinceId,
    required this.province,
  });

  @override
  List<Object> get props => [provinceId, province];

  Map<String, dynamic> toJson() => {
        'provinceId': provinceId,
        'province': province,
      };

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        provinceId: json['province_id'],
        province: json['province'],
      );

  Province toEntity() => Province(
        provinceId: provinceId,
        province: province,
      );
}
