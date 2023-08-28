import 'package:equatable/equatable.dart';

import 'package:beliyuk/data/models/city_model.dart';

class CityListResponseModel extends Equatable {
  final List<CityModel> results;

  const CityListResponseModel({
    required this.results,
  });

  @override
  List<Object> get props => [results];

  Map<String, dynamic> toJson() => {
        'results': results.map((city) => city.toJson()).toList(),
      };

  factory CityListResponseModel.fromJson(Map<String, dynamic> json) =>
      CityListResponseModel(
        results: List<CityModel>.from(
          json['rajaongkir']['results'].map((city) => CityModel.fromJson(city)),
        ),
      );
}
