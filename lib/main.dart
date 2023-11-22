import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/injection.dart' as di;
import 'package:beliyuk/presentation/blocs/auth/auth_bloc.dart';
import 'package:beliyuk/presentation/blocs/cart/cart_bloc.dart';
import 'package:beliyuk/presentation/blocs/checkout/checkout_bloc.dart';
import 'package:beliyuk/presentation/blocs/home/home_bloc.dart';
import 'package:beliyuk/presentation/blocs/main/main_bloc.dart';
import 'package:beliyuk/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:beliyuk/presentation/pages/main/main_page.dart';

void main() async {
  di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<CartBloc>()..add(DoGetAllCartEvent()),
        ),
        BlocProvider(
          create: (_) => di.locator<AuthBloc>()..add(DoAuthCheckEvent()),
        ),
        BlocProvider(
          create: (_) => di.locator<HomeBloc>()
            ..add(DoGetAllBanners())
            ..add(DoGetAllCategories())
            ..add(DoGetAllProducts()),
        ),
        BlocProvider(
          create: (_) => di.locator<CheckoutBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TransactionBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MainBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false),
        home: const MainPage(),
      ),
    );
  }
}
