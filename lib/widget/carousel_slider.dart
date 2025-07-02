import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utility/app_color.dart';
import '../models/product.dart';
import '../utility/utility_extention.dart';
import 'custom_network_image.dart';

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({
    super.key,
    required this.items,
  });

  final List<Images> items;

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  int newIndex = 0;
  late PageController _pageController; // Add PageController

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: newIndex); // Initialize PageController
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose PageController to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.38,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController, // Attach PageController
            itemCount: widget.items.length,
            onPageChanged: (int currentIndex) {
              setState(() {
                newIndex = currentIndex; // Update newIndex when swiping
              });
            },
            itemBuilder: (_, index) {
              return FittedBox(
                fit: BoxFit.cover,
                child: CustomNetworkImage(
                  imageUrl: widget.items.safeElementAt(index)?.url ?? '',
                  fit: BoxFit.fill,
                  scale: 3.0,
                ),
              );
            },
          ),
        ),
        AnimatedSmoothIndicator(
          effect: const WormEffect(
            dotColor: Colors.white,
            activeDotColor: AppColor.darkOrange,
          ),
          onDotClicked: (index) {
            setState(() {
              newIndex = index; // Update newIndex
            });
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ); // Navigate to the clicked page
          },
          count: widget.items.length,
          activeIndex: newIndex,
        ),
      ],
    );
  }
}