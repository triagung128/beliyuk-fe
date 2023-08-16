import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:beliyuk/bloc/auth/auth_bloc.dart';
import 'package:beliyuk/bloc/cart/cart_bloc.dart';
import 'package:beliyuk/bloc/search_product/search_product_bloc.dart';
import 'package:beliyuk/data/database/database_helper.dart';
import 'package:beliyuk/data/datasources/local/auth_local_datasource.dart';
import 'package:beliyuk/data/datasources/local/cart_local_datasource.dart';
import 'package:beliyuk/data/datasources/remote/auth_remote_datasource.dart';
import 'package:beliyuk/data/datasources/remote/product_remote_datasource.dart';
import 'package:beliyuk/presentation/pages/main/main_page.dart';

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
          create: (_) => SearchProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (_) => CartBloc(CartLocalDatasource(DatabaseHelper()))
            ..add(DoGetAllCartEvent()),
        ),
        BlocProvider(
          create: (_) => AuthBloc(
            remoteDatasource: AuthRemoteDatasource(),
            localDatasource: AuthLocalDatasource(),
          )..add(DoAuthCheckEvent()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
