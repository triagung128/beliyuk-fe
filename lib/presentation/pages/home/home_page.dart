import 'package:fic6_fe_beliyuk/presentation/common_widgets/custom_appbar_with_cart_icon.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/widgets/home_banner_widget.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/widgets/home_list_category_widget.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/widgets/home_list_product_widget.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/widgets/home_search_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBarWithCartIcon(
        automaticallyImplyLeading: false,
        title: Text('BeliYuk !'),
      ),
      body: Column(
        children: [
          const HomeSearchWidget(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              children: const [
                HomeBannerWidget(),
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
        ],
      ),
    );
  }
}
