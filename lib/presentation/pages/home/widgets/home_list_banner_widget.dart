import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/constants.dart';
import 'package:beliyuk/common/enum_state.dart';
import 'package:beliyuk/presentation/blocs/home/home_bloc.dart';

class HomeListBannerWidget extends StatelessWidget {
  HomeListBannerWidget({super.key});

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.bannersState == RequestState.loading) {
          return const SizedBox(
            height: 144,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.bannersState == RequestState.loaded &&
            state.banners.isNotEmpty) {
          return Column(
            children: [
              CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: state.banners.length,
                itemBuilder: (context, index, realIndex) {
                  final banner = state.banners[index];

                  return CachedNetworkImage(
                    imageUrl: '${Urls.baseUrl}${banner.image}',
                    imageBuilder: (context, imageProvider) => Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    progressIndicatorBuilder: (_, __, progress) => Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    errorWidget: (context, _, __) => Container(
                      height: 144,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[350],
                      ),
                      child: const Icon(
                        Icons.broken_image,
                        size: 48,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  pageViewKey: const PageStorageKey<String>('homeListBanner'),
                  viewportFraction: 1,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  height: 144,
                  onPageChanged: (index, x) {
                    context.read<HomeBloc>().add(SaveIndexIndicator(index));
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: state.banners.asMap().entries.map((entry) {
                  final bool isSelected =
                      state.indexCarouselSliderIndicator == entry.key;

                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(entry.key),
                    child: Container(
                      width: isSelected ? 12 : 6,
                      height: 6,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isSelected ? Colors.blue : Colors.grey,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }

        if (state.bannersState == RequestState.error) {
          return Container(
            height: 144,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[400],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.broken_image,
                  size: 38,
                ),
                const SizedBox(height: 8),
                Text(state.bannersMessage),
              ],
            ),
          );
        }

        return const SizedBox(height: 144);
      },
    );
  }
}
