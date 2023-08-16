import 'package:flutter/material.dart';

import 'package:beliyuk/presentation/pages/search_product/search_product_page.dart';

class HomeSearchWidget extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  HomeSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        controller: _searchController,
        onFieldSubmitted: (_) {
          if (_searchController.text != '') {
            final String value = _searchController.text;
            _searchController.text = '';
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SearchProductPage(productName: value)));
          }
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
          hintText: 'Mau beli produk apa hari ini ?',
        ),
      ),
    );
  }
}
