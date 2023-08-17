import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/domain/entities/category.dart';
import 'package:beliyuk/injection.dart' as di;
import 'package:beliyuk/presentation/blocs/category/category_bloc.dart';
import 'package:beliyuk/presentation/common_widgets/custom_appbar_with_cart_icon.dart';
import 'package:beliyuk/presentation/common_widgets/item_product.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.locator<CategoryBloc>()
        ..add(DoGetAllProductsByCategoryIdEvent(category.id)),
      child: Scaffold(
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
                category.name,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CategoryLoaded) {
              if (state.data.isNotEmpty) {
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.0 / 1.3,
                  ),
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    final product = state.data[index];
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

            if (state is CategoryError) {
              return Center(
                child: Text(state.message),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
