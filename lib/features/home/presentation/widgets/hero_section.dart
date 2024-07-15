import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_companion/core/utils/extensions.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(context),
        _latestPostsCarousel(),
      ].withSpaceBetween(10),
    );
  }

  CarouselSlider _latestPostsCarousel() {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (context, index, realIndex) => _carouselItemLayout(index),
      options: _carouselOptions(),
    );
  }

  CarouselOptions _carouselOptions() {
    return CarouselOptions(
      height: 200,
      enlargeCenterPage: true,
      enlargeFactor: 0.25,
      autoPlay: true,
      aspectRatio: 16 / 9,
      autoPlayCurve: Curves.easeInOutExpo,
      enableInfiniteScroll: true,
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      viewportFraction: 0.8,
      autoPlayInterval: const Duration(seconds: 10),
    );
  }

  Widget _carouselItemLayout(int index) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: _carouselItemContents(index),
    );
  }

  Widget _carouselItemContents(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _carouselItemContentImage(),
        // TODO: add post details
        Text("پست $index"),
      ].withSpaceBetween(10),
    );
  }

  Expanded _carouselItemContentImage() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(
            Random().nextInt(1000),
            Random().nextInt(1000),
            Random().nextInt(1000),
            1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Row _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _title(context),
        _viewAllButton(),
      ],
    );
  }

  TextButton _viewAllButton() {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {},
      child: const Text("مشاهده همه"),
    );
  }

  Widget _title(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        "آخرین پست ها",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
