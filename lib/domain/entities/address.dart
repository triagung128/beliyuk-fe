import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String name;
  final String phoneNumber;
  final String address;
  final Province province;
  final City city;

  const Address({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.province,
    required this.city,
  });

  @override
  List<Object> get props => [
        name,
        phoneNumber,
        address,
        province,
        city,
      ];
}

class Province extends Equatable {
  final String provinceId;
  final String province;

  const Province({
    required this.provinceId,
    required this.province,
  });

  @override
  List<Object> get props => [provinceId, province];
}

class City extends Equatable {
  final String cityId;
  final String provinceId;
  final String province;
  final String type;
  final String cityName;
  final String postalCode;

  const City({
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
}
