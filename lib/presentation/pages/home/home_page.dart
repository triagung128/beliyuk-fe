import 'package:fic6_fe_beliyuk/bloc/get_all_banner/get_all_banner_bloc.dart';
import 'package:fic6_fe_beliyuk/bloc/get_all_category/get_all_category_bloc.dart';
import 'package:fic6_fe_beliyuk/bloc/get_all_product/get_all_product_bloc.dart';
import 'package:fic6_fe_beliyuk/presentation/common_widgets/custom_appbar_with_cart_icon.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/widgets/home_banner_widget.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/widgets/home_list_category_widget.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/widgets/home_list_product_widget.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/widgets/home_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<GetAllBannerBloc>().add(DoGetAllBannerEvent());
      context.read<GetAllCategoryBloc>().add(DoGetAllCategoryEvent());
      context.read<GetAllProductBloc>().add(DoGetAllProductEvent());
    });
  }

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
