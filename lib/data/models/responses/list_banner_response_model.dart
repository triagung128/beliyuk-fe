import 'package:equatable/equatable.dart';
import 'package:beliyuk/data/models/banner_model.dart';
import 'package:beliyuk/data/models/meta_model.dart';

class ListBannerResponseModel extends Equatable {
  final List<BannerModel> data;
  final MetaModel meta;

  const ListBannerResponseModel({
    required this.data,
    required this.meta,
  });

  factory ListBannerResponseModel.fromJson(Map<String, dynamic> json) =>
      ListBannerResponseModel(
        data: List<BannerModel>.from(
            json['data'].map((banner) => BannerModel.fromJson(banner))),
        meta: MetaModel.fromJson(json['meta']),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((banner) => banner.toJson())),
        'meta': meta.toJson(),
      };

  @override
  List<Object> get props => [data, meta];
}
