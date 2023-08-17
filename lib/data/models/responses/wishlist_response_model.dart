import 'package:equatable/equatable.dart';

import 'package:beliyuk/data/models/wishlist_model.dart';

class WishlistResponseModel extends Equatable {
  final List<WishlistModel> wishlists;

  const WishlistResponseModel({
    required this.wishlists,
  });

  factory WishlistResponseModel.fromJson(Map<String, dynamic> json) =>
      WishlistResponseModel(
        wishlists: List<WishlistModel>.from(
          json["data"].map((whistlist) => WishlistModel.fromJson(whistlist)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(
            wishlists.map((whistlist) => whistlist.toJson())),
      };

  @override
  List<Object> get props => [wishlists];
}
