import 'package:carousel_slider/carousel_slider.dart';
import 'package:fic6_fe_beliyuk/bloc/get_all_banner/get_all_banner_bloc.dart';
import 'package:fic6_fe_beliyuk/common/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBannerWidget extends StatefulWidget {
  const HomeBannerWidget({super.key});

  @override
  State<HomeBannerWidget> createState() => _HomeBannerWidgetState();
}

class _HomeBannerWidgetState extends State<HomeBannerWidget> {
  final CarouselController _carouselController = CarouselController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllBannerBloc, GetAllBannerState>(
      builder: (context, state) {
        if (state is GetAllBannerLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is GetAllBannerLoaded) {
          return Column(
            children: [
              CarouselSlider(
                carouselController: _carouselController,
                items: state.data.data
                    .map((item) => Builder(
                          builder: (_) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '${GlobalVariables.baseUrl}${item.attributes.image.data.attributes.url}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ))
                    .toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  height: 144,
                  onPageChanged: (index, _) {
                    setState(() => _currentIndex = index);
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: state.data.data.asMap().entries.map((entry) {
                  final bool isSelected = _currentIndex == entry.key;

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

        if (state is GetAllBannerError) {
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
                Text(state.messageError),
              ],
            ),
          );
        }

        return Container(
          height: 144,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[400],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image,
                size: 38,
              ),
              SizedBox(height: 8),
              Text('Failed get data banner !'),
            ],
          ),
        );
      },
    );
  }
}
