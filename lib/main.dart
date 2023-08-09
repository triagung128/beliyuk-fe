import 'package:fic6_fe_beliyuk/bloc/get_all_banner/get_all_banner_bloc.dart';
import 'package:fic6_fe_beliyuk/bloc/get_all_category/get_all_category_bloc.dart';
import 'package:fic6_fe_beliyuk/bloc/get_all_product/get_all_product_bloc.dart';
import 'package:fic6_fe_beliyuk/data/datasources/banner_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/data/datasources/category_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/data/datasources/product_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
          create: (_) => GetAllProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (_) => GetAllCategoryBloc(CategoryRemoteDatasource()),
        ),
        BlocProvider(
          create: (_) => GetAllBannerBloc(BannerRemoteDatasource()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
