import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/bloc/search_product/search_product_bloc.dart';
import 'package:fic6_fe_beliyuk/presentation/common_widgets/custom_appbar_with_cart_icon.dart';
import 'package:fic6_fe_beliyuk/presentation/common_widgets/item_product.dart';

class SearchProductPage extends StatefulWidget {
  final String productName;

  const SearchProductPage({
    super.key,
    required this.productName,
  });

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.productName;
    context
        .read<SearchProductBloc>()
        .add(DoSearchProductEvent(productName: widget.productName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBarWithCartIcon(
        title: Text('Pencarian Produk'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              controller: _searchController,
              onFieldSubmitted: (_) {
                context.read<SearchProductBloc>().add(
                    DoSearchProductEvent(productName: _searchController.text));
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
                  if (state.data.data.isNotEmpty) {
                    return GridView.builder(
                      key: const PageStorageKey<String>('searchProduct'),
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                        const Text('Produk yang Anda cari tidak ditemukan !'),
                      ],
                    );
                  }
                }

                if (state is SearchProductError) {
                  return Center(
                    child: Text(state.messageError),
                  );
                }

                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
