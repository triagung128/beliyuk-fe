import 'package:flutter/material.dart';

import 'package:beliyuk/presentation/pages/search_product/search_product_page.dart';

class HomeSearchWidget extends StatefulWidget {
  const HomeSearchWidget({super.key});

  @override
  State<HomeSearchWidget> createState() => _HomeSearchWidgetState();
}

class _HomeSearchWidgetState extends State<HomeSearchWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      child: TextFormField(
        controller: _searchController,
        onFieldSubmitted: (_) {
          if (_searchController.text != '') {
            final String value = _searchController.text;
            _searchController.text = '';
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return SearchProductPage(productName: value);
            }));
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
