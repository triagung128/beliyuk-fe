import 'package:equatable/equatable.dart';

import 'package:beliyuk/data/models/banner_model.dart';

class ListBannerResponseModel extends Equatable {
  final List<BannerModel> banners;

  const ListBannerResponseModel({
    required this.banners,
  });

  factory ListBannerResponseModel.fromJson(Map<String, dynamic> json) =>
      ListBannerResponseModel(
        banners: List<BannerModel>.from(
            json['data'].map((banner) => BannerModel.fromJson(banner))),
      );

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(banners.map((banner) => banner.toJson())),
      };

  @override
  List<Object> get props => [banners];
}
