import 'package:cached_network_image/cached_network_image.dart';
import 'package:fic6_fe_beliyuk/data/models/category_model.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/category/category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/bloc/get_all_category/get_all_category_bloc.dart';
import 'package:fic6_fe_beliyuk/common/global_variables.dart';

class HomeListCategoryWidget extends StatelessWidget {
  const HomeListCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: BlocBuilder<GetAllCategoryBloc, GetAllCategoryState>(
        builder: (context, state) {
          if (state is GetAllCategoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GetAllCategoryLoaded) {
            return ListView.builder(
              key: const PageStorageKey<String>('homeListCategory'),
              itemCount: state.data.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = state.data.data[index];

                return ItemCategory(
                  category: category,
                  index: index,
                );
              },
            );
          }

          if (state is GetAllCategoryError) {
            return Center(
              child: Text(state.messageError),
            );
          }

          return Container(height: 110);
        },
      ),
    );
  }
}

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
