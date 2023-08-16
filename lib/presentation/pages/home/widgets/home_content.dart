import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/bloc/home/home_bloc.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/widgets/home_list_banner_widget.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/widgets/home_list_category_widget.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/widgets/home_list_product_widget.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/widgets/home_search_widget.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeSearchWidget(),
        const SizedBox(height: 16),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(
                const Duration(seconds: 1),
                () {
                  context.read<HomeBloc>()
                    ..add(DoGetAllBanners())
                    ..add(DoGetAllCategories())
                    ..add(DoGetAllProducts());
                },
              );
            },
            child: ListView(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              children: const [
                HomeListBannerWidget(),
                SizedBox(height: 16),
                Text(
                  'Kategori',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                HomeListCategoryWidget(),
                SizedBox(height: 16),
                Text(
                  'List Produk',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                HomeListProductWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
