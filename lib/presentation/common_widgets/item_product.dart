import 'package:fic6_fe_beliyuk/common/int_extensions.dart';
import 'package:fic6_fe_beliyuk/common/global_variables.dart';
import 'package:fic6_fe_beliyuk/data/models/product_model.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/detail_product/detail_product_page.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatelessWidget {
  final ProductModel product;

  const ItemProduct({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailProductPage(product: product);
          }));
        },
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Hero(
                tag: 'product#${product.id}',
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(
                          '${GlobalVariables.baseUrl}${product.attributes.images.data[0].attributes.url}'),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.attributes.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.attributes.price.intToFormatRupiah,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
