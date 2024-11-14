import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_handy_utils/flutter_handy_utils.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core_export.dart';
import '../../../posts_exports.dart';

class FeaturedImageInput extends StatefulWidget {
  final String? initialPostImageLink;
  const FeaturedImageInput({super.key, this.initialPostImageLink});

  @override
  State<FeaturedImageInput> createState() => _FeaturedImageInputState();
}

class _FeaturedImageInputState extends State<FeaturedImageInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "عکس شاخص"),
        _imageSelector(),
        _featuredImageHelperText(),
        _deleteFeaturedImage(),
      ].withGapInBetween(15),
    );
  }

  Widget _imageSelector() {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () async {
          await _showImageSelector();
        },
        borderRadius: BorderRadius.circular(mediumCornerRadius),
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(color: ColorPallet.border),
            borderRadius: BorderRadius.circular(mediumCornerRadius),
          ),
          clipBehavior: Clip.antiAlias,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(mediumCornerRadius),
            child: CachedNetworkImage(
              imageUrl: widget.initialPostImageLink ?? "",
              height: 200,
              width: 200,
              fit: BoxFit.cover,
              errorWidget: (context, error, stackTrace) {
                return const Icon(Icons.image);
              },
              errorListener: (value) {
                print(value);
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showImageSelector() async {
    final selectedImage = await context.push(imageSelectorRoute);
    print(selectedImage);
  }

  Widget _featuredImageHelperText() {
    return Text(
      "برای تغییر عکس آن را لمس کنید.",
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  Widget _deleteFeaturedImage() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: ColorPallet.crimson,
      ),
      child: const Text("حذف عکس"),
    );
  }
}
