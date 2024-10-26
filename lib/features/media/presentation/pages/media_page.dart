import 'package:flutter/material.dart';

import '../../../../core/core_export.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        _listOfMedia(),
      ],
    );
  }

  Widget _header() {
    return PageHeaderLayout(
      leftWidget: CustomSearchInput(
        onChanged: (value) {},
      ),
      rightWidget: const FilterButton(),
    );
  }

  Widget _listOfMedia() {
    return const Expanded(
      flex: 9,
      child: Placeholder(),
    );
  }
}
