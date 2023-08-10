import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:fic6_fe_beliyuk/common/global_variables.dart';
import 'package:fic6_fe_beliyuk/common/int_extensions.dart';
import 'package:fic6_fe_beliyuk/data/models/product_model.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/detail_product/detail_product_page.dart';

class ItemProduct extends StatelessWidget {
  final ProductModel product;
  final String tagHero = 'product#${DateTime.now().millisecondsSinceEpoch}';

  ItemProduct({
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
            return DetailProductPage(
              product: product,
              tagHero: tagHero,
            );
          }));
        },
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: tagHero,
                child: CachedNetworkImage(
                  imageUrl:
                      '${GlobalVariables.baseUrl}${product.attributes.images.data[0].attributes.url}',
                  imageBuilder: (context, imageProvider) => Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      image: DecorationImage(image: imageProvider),
                    ),
                  ),
                  progressIndicatorBuilder: (_, __, progress) => Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                    ),
                    child: const Icon(Icons.broken_image, size: 62),
                  ),
                  height: 120,
                  fit: BoxFit.contain,
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
