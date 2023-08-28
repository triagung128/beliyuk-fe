import 'package:equatable/equatable.dart';

import 'package:beliyuk/domain/entities/address.dart';

class CityModel extends Equatable {
  final String cityId;
  final String provinceId;
  final String province;
  final String type;
  final String cityName;
  final String postalCode;

  const CityModel({
    required this.cityId,
    required this.provinceId,
    required this.province,
    required this.type,
    required this.cityName,
    required this.postalCode,
  });

  @override
  List<Object> get props => [
        cityId,
        provinceId,
        province,
        type,
        cityName,
        postalCode,
      ];

  Map<String, dynamic> toJson() => {
        'cityId': cityId,
        'provinceId': provinceId,
        'province': province,
        'type': type,
        'cityName': cityName,
        'postalCode': postalCode,
      };

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        cityId: json['city_id'],
        provinceId: json['province_id'],
        province: json['province'],
        type: json['type'],
        cityName: json['city_name'],
        postalCode: json['postal_code'],
      );

  City toEntity() => City(
        cityId: cityId,
        provinceId: provinceId,
        province: province,
        type: type,
        cityName: cityName,
        postalCode: postalCode,
      );
}
