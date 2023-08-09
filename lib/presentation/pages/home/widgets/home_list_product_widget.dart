import 'package:fic6_fe_beliyuk/bloc/bloc/get_all_product_bloc.dart';
import 'package:fic6_fe_beliyuk/presentation/common_widgets/item_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeListProductWidget extends StatefulWidget {
  const HomeListProductWidget({super.key});

  @override
  State<HomeListProductWidget> createState() => _HomeListProductWidgetState();
}

class _HomeListProductWidgetState extends State<HomeListProductWidget> {
  @override
  void initState() {
    super.initState();
    context.read<GetAllProductBloc>().add(DoGetAllProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllProductBloc, GetAllProductState>(
      builder: (context, state) {
        if (state is GetAllProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetAllProductLoaded) {
          return GridView.builder(
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

        return const Center(
          child: Text('Failed Get Data!'),
        );
      },
    );
  }
}
