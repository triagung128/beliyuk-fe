class MetaModel {
  final Pagination pagination;

  MetaModel({
    required this.pagination,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
        pagination: Pagination.fromJson(json['pagination']),
      );

  Map<String, dynamic> toJson() => {
        'pagination': pagination.toJson(),
      };
}

class Pagination {
  final int page;
  final int pageSize;
  final int pageCount;
  final int total;

  Pagination({
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
}
