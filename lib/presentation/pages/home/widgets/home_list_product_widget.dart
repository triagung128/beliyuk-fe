import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/bloc/get_all_product/get_all_product_bloc.dart';
import 'package:fic6_fe_beliyuk/presentation/common_widgets/item_product.dart';

class HomeListProductWidget extends StatelessWidget {
  const HomeListProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllProductBloc, GetAllProductState>(
      builder: (context, state) {
        if (state is GetAllProductLoading) {
          return const SizedBox(
            height: 110,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is GetAllProductLoaded) {
          return GridView.builder(
            key: const PageStorageKey<String>('homeListProduct'),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.0 / 1.3,
            ),
            itemCount: state.data.data.length,
            itemBuilder: (context, index) {
              final product = state.data.data[index];
              return ItemProduct(product: product);
            },
          );
        }

        if (state is GetAllProductError) {
          return Center(
            child: Text(state.messageError),
          );
        }

        return Container();
      },
    );
  }
}
