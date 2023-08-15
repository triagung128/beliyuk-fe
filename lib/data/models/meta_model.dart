import 'package:equatable/equatable.dart';

class MetaModel extends Equatable {
  final Pagination? pagination;

  const MetaModel({
    required this.pagination,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
        pagination: json['pagination'] == null
            ? null
            : Pagination.fromJson(json['pagination']),
      );

  Map<String, dynamic> toJson() => {
        'pagination': pagination?.toJson(),
      };

  @override
  List<Object?> get props => [pagination];
}

class Pagination extends Equatable {
  final int page;
  final int pageSize;
  final int pageCount;
  final int total;

  const Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json['page'],
        pageSize: json['pageSize'],
        pageCount: json['pageCount'],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        'page': page,
        'pageSize': pageSize,
        'pageCount': pageCount,
        'total': total,
      };

  @override
  List<Object> get props => [
        page,
        pageSize,
        pageCount,
        total,
      ];
}
