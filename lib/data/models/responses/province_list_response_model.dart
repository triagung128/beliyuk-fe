import 'package:equatable/equatable.dart';

import 'package:beliyuk/data/models/province_model.dart';

class ProvinceListReponseModel extends Equatable {
  final List<ProvinceModel> results;

  const ProvinceListReponseModel({
    required this.results,
  });

  @override
  List<Object> get props => [results];

  Map<String, dynamic> toJson() => {
        'results': results.map((province) => province.toJson()).toList(),
      };

  factory ProvinceListReponseModel.fromJson(Map<String, dynamic> json) =>
      ProvinceListReponseModel(
        results: List<ProvinceModel>.from(
          json['rajaongkir']['results'].map(
            (province) => ProvinceModel.fromJson(province),
          ),
        ),
      );
}
