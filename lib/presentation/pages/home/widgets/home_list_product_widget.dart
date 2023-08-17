import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/enum_state.dart';
import 'package:beliyuk/presentation/blocs/home/home_bloc.dart';
import 'package:beliyuk/presentation/common_widgets/item_product.dart';

class HomeListProductWidget extends StatelessWidget {
  const HomeListProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.productsState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.productsState == RequestState.loaded &&
            state.products.isNotEmpty) {
          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.0 / 1.5,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ItemProduct(product: product);
            },
          );
        }

        if (state.productsState == RequestState.error) {
          return Center(
            child: Text(state.productsMessage),
          );
        }

        return const SizedBox();
      },
    );
  }
}
