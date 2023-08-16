import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/bloc/home/home_bloc.dart';
import 'package:fic6_fe_beliyuk/data/datasources/remote/banner_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/data/datasources/remote/category_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/data/datasources/remote/product_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/presentation/common_widgets/custom_appbar_with_cart_icon.dart';
import 'package:fic6_fe_beliyuk/presentation/pages/home/widgets/home_content.dart';

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
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBarWithCartIcon(
          automaticallyImplyLeading: false,
          title: Text('BeliYuk !'),
        ),
        body: HomeContent(),
      ),
    );
  }
}
