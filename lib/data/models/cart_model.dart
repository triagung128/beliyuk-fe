import 'package:fic6_fe_beliyuk/data/models/product_model.dart';

class CartModel {
  final ProductModel product;
  int qty;

  CartModel({
    required this.product,
    this.qty = 0,
  });
}
