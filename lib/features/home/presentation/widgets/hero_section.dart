import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wordpress_companion/core/utils/extensions.dart';
import 'package:wordpress_companion/core/utils/string_formatter.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(),
        _latestPostsCarousel(),
      ],
    );
  }

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _title(),
        _viewAllButton(),
      ],
    );
  }

  Widget _title() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        "آخرین پست ها",
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _viewAllButton() {
    return SizedBox(
      height: 30,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 5),
        ),
        onPressed: () {},
        child: const Text("مشاهده همه"),
      ),
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
      height: 240,
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
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: _carouselItemContents(index),
    );
  }

  Widget _carouselItemContents(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _carouselItemContentImage(),
        _carouselItemContentTitle(index),
        _carouselItemContentSubTitle(),
        _carouselItemContentFootnote(),
      ].withSpaceBetween(5),
    );
  }

  Text _carouselItemContentTitle(int index) {
    return Text("پست $index");
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

  Widget _carouselItemContentSubTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringFormatter.shortenText(
            "Exercitation deserunt incididunt consectetur fugiat amet qui.",
            50,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Row _carouselItemContentFootnote() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "1403/04/14",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const Gap(
          5,
          crossAxisExtent: 1,
          color: Colors.black26,
        ),
        Text(
          "انتشار داده شده",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
