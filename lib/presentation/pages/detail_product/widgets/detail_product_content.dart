import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/constants.dart';
import 'package:beliyuk/common/int_extensions.dart';
import 'package:beliyuk/domain/entities/product.dart';
import 'package:beliyuk/presentation/blocs/detail_product/detail_product_bloc.dart';

class DetailProductContent extends StatefulWidget {
  const DetailProductContent({
    required this.product,
    required this.isAddedToWishlist,
    super.key,
  });

  final Product product;
  final bool isAddedToWishlist;

  @override
  State<DetailProductContent> createState() => _DetailProductContentState();
}

class _DetailProductContentState extends State<DetailProductContent> {
  int _indexCarouselSlider = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider.builder(
                itemCount: widget.product.images.length,
                itemBuilder: (context, index, _) {
                  final String imageUrl = widget.product.images[index];

                  return CachedNetworkImage(
                    imageUrl: '${Urls.baseUrl}$imageUrl',
                    imageBuilder: (context, imageProvider) => Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: imageProvider,
                        ),
                      ),
                    ),
                    progressIndicatorBuilder: (_, __, progress) => SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                    ),
                    errorWidget: (context, _, __) => Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                      ),
                      child: const Icon(Icons.broken_image, size: 62),
                    ),
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: false,
                  height: 370,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, _) {
                    setState(() => _indexCarouselSlider = index);
                  },
                ),
              ),
              Positioned(
                bottom: 16,
                child: Row(
                  children: widget.product.images.asMap().entries.map((entry) {
                    final bool isSelected = _indexCarouselSlider == entry.key;

                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: isSelected ? 8 : 6,
                        height: isSelected ? 8 : 6,
                        margin: const EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? Colors.blue : Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.price.intToFormatRupiah,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (!widget.isAddedToWishlist) {
                          context
                              .read<DetailProductBloc>()
                              .add(AddWishlistDetailProductEvent(
                                productId: widget.product.id,
                                name: widget.product.name,
                                price: widget.product.price,
                                weight: widget.product.weight,
                                image: widget.product.images[0],
                              ));
                        } else {
                          context.read<DetailProductBloc>().add(
                              RemoveWishlistDetailProductEvent(
                                  widget.product.id));
                        }
                      },
                      icon: Icon(
                        widget.isAddedToWishlist
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  widget.product.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(thickness: 0.5),
                const SizedBox(height: 8),
                const Text(
                  'Detail Produk',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Table(
                  children: [
                    TableRow(
                      children: [
                        const Text('Berat satuan'),
                        Text(widget.product.weight.convertUnitWeight),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text('Kategori'),
                        Text(widget.product.category.name),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(thickness: 0.5),
                const SizedBox(height: 8),
                const Text(
                  'Deskripsi Produk',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(widget.product.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
