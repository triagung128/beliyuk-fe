import 'package:fic6_fe_beliyuk/bloc/get_products_by_category_id/get_products_by_category_id_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:fic6_fe_beliyuk/bloc/get_all_banner/get_all_banner_bloc.dart';
import 'package:fic6_fe_beliyuk/bloc/get_all_category/get_all_category_bloc.dart';
import 'package:fic6_fe_beliyuk/bloc/get_all_product/get_all_product_bloc.dart';
import 'package:fic6_fe_beliyuk/bloc/search_product/search_product_bloc.dart';
import 'package:fic6_fe_beliyuk/data/datasources/banner_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/data/datasources/category_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/data/datasources/product_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/main/main_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetAllProductBloc(ProductRemoteDatasource())
            ..add(DoGetAllProductEvent()),
        ),
        BlocProvider(
          create: (_) => GetAllCategoryBloc(CategoryRemoteDatasource())
            ..add(DoGetAllCategoryEvent()),
        ),
        BlocProvider(
          create: (_) => GetAllBannerBloc(BannerRemoteDatasource())
            ..add(DoGetAllBannerEvent()),
        ),
        BlocProvider(
          create: (_) => SearchProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (_) => GetProductsByCategoryIdBloc(ProductRemoteDatasource()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
