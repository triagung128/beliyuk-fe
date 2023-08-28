import 'package:equatable/equatable.dart';

import 'package:beliyuk/domain/entities/courier.dart';

class CourierModel extends Equatable {
  final String code;
  final String name;
  final List<CourierServiceModel> costs;

  const CourierModel({
    required this.code,
    required this.name,
    required this.costs,
  });

  @override
  List<Object> get props => [code, name, costs];

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'costs': costs.map((cost) => cost.toJson()).toList(),
      };

  factory CourierModel.fromMap(Map<String, dynamic> json) => CourierModel(
        code: json['code'],
        name: json['name'],
        costs: List<CourierServiceModel>.from(
          json['costs'].map((cost) => CourierServiceModel.fromJson(cost)),
        ),
      );

  Courier toEntity() => Courier(
        code: code,
        name: name,
        costs: costs.map((cost) => cost.toEntity()).toList(),
      );
}

class CourierServiceModel extends Equatable {
  final String service;
  final String description;
  final List<CourierServiceCostModel> cost;

  const CourierServiceModel({
    required this.service,
    required this.description,
    required this.cost,
  });

  @override
  List<Object> get props => [service, description, cost];

  Map<String, dynamic> toJson() => {
        'service': service,
        'description': description,
        'cost': cost.map((cost) => cost.toJson()).toList(),
      };

  factory CourierServiceModel.fromJson(Map<String, dynamic> json) =>
      CourierServiceModel(
        service: json['service'],
        description: json['description'],
        cost: List<CourierServiceCostModel>.from(
          json['cost'].map((cost) => CourierServiceCostModel.fromJson(cost)),
        ),
      );

  CourierService toEntity() => CourierService(
        service: service,
        description: description,
        cost: cost.first.toEntity(),
      );
}

class CourierServiceCostModel extends Equatable {
  final int value;
  final String etd;
  final String note;

  const CourierServiceCostModel({
    required this.value,
    required this.etd,
    required this.note,
  });

  @override
  List<Object> get props => [value, etd, note];

  Map<String, dynamic> toJson() => {
        'value': value,
        'etd': etd,
        'note': note,
      };

  factory CourierServiceCostModel.fromJson(Map<String, dynamic> json) =>
      CourierServiceCostModel(
        value: json['value'],
        etd: json['etd'],
        note: json['note'],
      );

  CourierServiceCost toEntity() => CourierServiceCost(
        value: value,
        etd: etd,
        note: note,
      );
}
