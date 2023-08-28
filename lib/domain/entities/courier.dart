import 'package:equatable/equatable.dart';

class Courier extends Equatable {
  final String code;
  final String name;
  final List<CourierService> costs;

  const Courier({
    required this.code,
    required this.name,
    required this.costs,
  });

  @override
  List<Object> get props => [code, name, costs];
}

class CourierService extends Equatable {
  final String service;
  final String description;
  final CourierServiceCost cost;

  const CourierService({
    required this.service,
    required this.description,
    required this.cost,
  });

  @override
  List<Object> get props => [service, description, cost];
}

class CourierServiceCost extends Equatable {
  final int value;
  final String etd;
  final String note;

  const CourierServiceCost({
    required this.value,
    required this.etd,
    required this.note,
  });

  @override
  List<Object> get props => [value, etd, note];
}
