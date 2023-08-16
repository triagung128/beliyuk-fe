import 'package:beliyuk/bloc/home/home_bloc.dart';
import 'package:beliyuk/data/datasources/remote/banner_remote_datasource.dart';
import 'package:beliyuk/data/datasources/remote/category_remote_datasource.dart';
import 'package:beliyuk/data/datasources/remote/product_remote_datasource.dart';
import 'package:beliyuk/presentation/common_widgets/custom_appbar_with_cart_icon.dart';
import 'package:beliyuk/presentation/pages/home/widgets/home_list_banner_widget.dart';
import 'package:beliyuk/presentation/pages/home/widgets/home_list_category_widget.dart';
import 'package:beliyuk/presentation/pages/home/widgets/home_list_product_widget.dart';
import 'package:beliyuk/presentation/pages/home/widgets/home_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        bannerRemoteDatasource: BannerRemoteDatasource(),
        categoryRemoteDatasource: CategoryRemoteDatasource(),
        productRemoteDatasource: ProductRemoteDatasource(),
      )
        ..add(DoGetAllBanners())
        ..add(DoGetAllCategories())
        ..add(DoGetAllProducts()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBarWithCartIcon(
          automaticallyImplyLeading: false,
          title: Text('BeliYuk !'),
        ),
        body: Column(
          children: [
            HomeSearchWidget(),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return RefreshIndicator(
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
