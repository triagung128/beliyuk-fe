import 'package:carousel_slider/carousel_slider.dart';
import 'package:fic6_fe_beliyuk/common/global_variables.dart';
import 'package:flutter/material.dart';

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
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          items: GlobalVariables.bannerImages
              .map((item) => Builder(
                    builder: (_) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(item),
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
          children: GlobalVariables.bannerImages.asMap().entries.map((entry) {
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
}
