import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:beliyuk/common/global_variables.dart';
import 'package:beliyuk/common/int_extensions.dart';
import 'package:beliyuk/data/models/product_model.dart';
import 'package:beliyuk/presentation/pages/detail_product/detail_product_page.dart';

class ItemProduct extends StatelessWidget {
  final ProductModel product;

  const ItemProduct({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailProductPage(productId: product.id),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl:
                    '${GlobalVariables.baseUrl}${product.attributes.images.data[0].attributes.url}',
                imageBuilder: (context, imageProvider) => Container(
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
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                  child: const Icon(Icons.broken_image, size: 62),
                ),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: 95,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.attributes.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
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
