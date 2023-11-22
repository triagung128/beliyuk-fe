import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/presentation/blocs/home/home_bloc.dart';
import 'package:beliyuk/presentation/common_widgets/custom_appbar_with_cart_icon.dart';
import 'package:beliyuk/presentation/pages/home/widgets/home_list_banner_widget.dart';
import 'package:beliyuk/presentation/pages/home/widgets/home_list_category_widget.dart';
import 'package:beliyuk/presentation/pages/home/widgets/home_list_product_widget.dart';
import 'package:beliyuk/presentation/pages/home/widgets/home_search_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarWithCartIcon(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo_transparent.png',
              width: 32,
              height: 32,
            ),
            const Text('Beli Yuk'),
          ],
        ),
      ),
      body: Column(
        children: [
          HomeSearchWidget(),
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
                key: const PageStorageKey('homeListView'),
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                children: [
                  HomeListBannerWidget(),
                  const SizedBox(height: 16),
                  const Text(
                    'Kategori',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const HomeListCategoryWidget(),
                  const SizedBox(height: 16),
                  const Text(
                    'Produk Hari Ini',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const HomeListProductWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
