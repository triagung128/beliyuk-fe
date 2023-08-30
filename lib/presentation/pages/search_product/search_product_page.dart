import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/injection.dart' as di;
import 'package:beliyuk/presentation/blocs/search_product/search_product_bloc.dart';
import 'package:beliyuk/presentation/common_widgets/custom_appbar_with_cart_icon.dart';
import 'package:beliyuk/presentation/common_widgets/item_product.dart';

class SearchProductPage extends StatefulWidget {
  final String query;

  const SearchProductPage({
    super.key,
    required this.query,
  });

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.query;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.locator<SearchProductBloc>()
        ..add(DoSearchProductEvent(query: widget.query)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBarWithCartIcon(
          title: Text('Pencarian Produk'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<SearchProductBloc, SearchProductState>(
                builder: (context, state) {
                  return TextFormField(
                    controller: _searchController,
                    onFieldSubmitted: (_) {
                      context.read<SearchProductBloc>().add(
                          DoSearchProductEvent(query: _searchController.text));
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(),
                      ),
                      hintText: 'Cari produk disini',
                    ),
                  );
                },
              ),
            ),
            const Divider(thickness: 0.5, height: 0),
            Expanded(
              child: BlocBuilder<SearchProductBloc, SearchProductState>(
                builder: (context, state) {
                  if (state is SearchProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is SearchProductLoaded) {
                    if (state.products.isNotEmpty) {
                      return GridView.builder(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.0 / 1.3,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ItemProduct(product: product);
                        },
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/empty-product.png',
                            height: 150,
                            width: 150,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Opss...',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          const Text('Produk yang Anda cari tidak ditemukan!'),
                        ],
                      );
                    }
                  }

                  if (state is SearchProductError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
