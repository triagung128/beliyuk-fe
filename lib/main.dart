import 'package:fic6_fe_beliyuk/bloc/bloc/get_all_product_bloc.dart';
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
    return BlocProvider(
      create: (_) => GetAllProductBloc(ProductRemoteDatasource()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
