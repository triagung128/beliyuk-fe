import 'package:cached_network_image/cached_network_image.dart';
import 'package:fic6_fe_beliyuk/common/global_variables.dart';
import 'package:fic6_fe_beliyuk/data/models/category_model.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/category/category_page.dart';
import 'package:flutter/material.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({
    super.key,
    required this.category,
    required this.index,
  });

  final CategoryModel category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: EdgeInsets.only(left: index == 0 ? 0 : 6),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return CategoryPage(category: category);
          }));
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl:
                    '${GlobalVariables.baseUrl}${category.attributes.logo.data.attributes.url}',
                imageBuilder: (_, imageProvider) => Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: imageProvider),
                  ),
                ),
                progressIndicatorBuilder: (_, __, progress) => SizedBox(
                  height: 60,
                  width: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.broken_image),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                category.attributes.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
