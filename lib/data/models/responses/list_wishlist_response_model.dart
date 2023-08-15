import 'package:equatable/equatable.dart';

import 'package:fic6_fe_beliyuk/data/models/meta_model.dart';
import 'package:fic6_fe_beliyuk/data/models/wishlist_model.dart';

class ListWishlistResponseModel extends Equatable {
  final List<WishlistModel> data;
  final MetaModel meta;

  const ListWishlistResponseModel({
    required this.data,
    required this.meta,
  });

  factory ListWishlistResponseModel.fromJson(Map<String, dynamic> json) =>
      ListWishlistResponseModel(
        data: List<WishlistModel>.from(
          json["data"].map((whistlist) => WishlistModel.fromJson(whistlist)),
        ),
        meta: MetaModel.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((whistlist) => whistlist.toJson())),
        "meta": meta.toJson(),
      };

  @override
  List<Object> get props => [data, meta];
}
