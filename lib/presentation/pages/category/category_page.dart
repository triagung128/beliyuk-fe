import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/bloc/get_products_by_category_id/get_products_by_category_id_bloc.dart';
import 'package:fic6_fe_beliyuk/data/models/category_model.dart';
import 'package:fic6_fe_beliyuk/presentation/common_widgets/custom_appbar_with_cart_icon.dart';
import 'package:fic6_fe_beliyuk/presentation/common_widgets/item_product.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<GetProductsByCategoryIdBloc>()
        .add(DoGetProductsByCategoryIdEvent(widget.category.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithCartIcon(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kategori :',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 2),
            Text(
              widget.category.attributes.name,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      body: BlocBuilder<GetProductsByCategoryIdBloc,
          GetProductsByCategoryIdState>(
        builder: (context, state) {
          if (state is GetProductsByCategoryIdLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GetProductsByCategoryIdLoaded) {
            if (state.data.data.isNotEmpty) {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
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
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/product-empty.png',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Opss...',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  const Text('Kategori ini belum memiliki produk !'),
                ],
              );
            }
          }

          if (state is GetProductsByCategoryIdError) {
            return Center(
              child: Text(state.messageError),
            );
          }

          return Container();
        },
      ),
    );
  }
}
