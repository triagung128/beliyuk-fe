import 'package:equatable/equatable.dart';

import 'package:beliyuk/data/models/courier_model.dart';

class CourierListResponseModel extends Equatable {
  final List<CourierModel> results;

  const CourierListResponseModel({
    required this.results,
  });

  @override
  List<Object> get props => [results];

  Map<String, dynamic> toJson() => {
        'results': results.map((courier) => courier.toJson()).toList(),
      };

  factory CourierListResponseModel.fromJson(Map<String, dynamic> json) =>
      CourierListResponseModel(
        results: List<CourierModel>.from(
          json['rajaongkir']['results'].map(
            (courier) => CourierModel.fromMap(courier),
          ),
        ),
      );
}
