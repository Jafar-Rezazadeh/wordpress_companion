import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_handy_utils/flutter_handy_utils.dart';
import 'package:get/get.dart';
import 'package:wordpress_companion/features/media/domain/entities/media_entity.dart';

import '../../../../../core/core_export.dart';
import '../../../posts_exports.dart';

class FeaturedImageInput extends StatefulWidget {
  final String? initialPostImageLink;
  final Function(MediaEntity media) onImageSelected;
  final VoidCallback onClearImage;
  const FeaturedImageInput({
    super.key,
    this.initialPostImageLink,
    required this.onImageSelected,
    required this.onClearImage,
  });

  @override
  State<FeaturedImageInput> createState() => _FeaturedImageInputState();
}

class _FeaturedImageInputState extends State<FeaturedImageInput> {
  String? selectedImageLink;

  @override
  void initState() {
    super.initState();
    selectedImageLink = widget.initialPostImageLink;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "عکس شاخص"),
        _imageSelector(),
        _featuredImageHelperText(),
        _removeFeaturedImage(),
      ].withGapInBetween(15),
    );
  }

  Widget _imageSelector() {
    return Align(
      key: const Key("image_selector"),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () async => await _showImageSelector(),
        borderRadius: BorderRadius.circular(mediumCornerRadius),
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            border: Border.all(color: ColorPallet.border),
            borderRadius: BorderRadius.circular(mediumCornerRadius),
          ),
          clipBehavior: Clip.antiAlias,
          child: _imageRenderer(),
        ),
      ),
    );
  }

  ClipRRect _imageRenderer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(mediumCornerRadius),
      child: CachedNetworkImage(
        imageUrl:
            selectedImageLink?.replaceAll("localhost", "192.168.1.2") ?? "",
        height: 200,
        width: 200,
        fit: BoxFit.cover,
        errorWidget: (context, error, stackTrace) {
          return const Icon(Icons.image);
        },
        errorListener: (value) {},
      ),
    );
  }

  Future<dynamic> _showImageSelector() async {
    final MediaEntity? selectedImage =
        await Get.toNamed(imageSelectorRoute) as MediaEntity?;

    if (selectedImage != null) {
      widget.onImageSelected(selectedImage);
      setState(() {
        selectedImageLink = selectedImage.sourceUrl;
      });
    }
  }

  Widget _featuredImageHelperText() {
    return Text(
      "برای تغییر عکس آن را لمس کنید.",
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  Widget _removeFeaturedImage() {
    return TextButton(
      key: const Key("remove_image"),
      onPressed: () {
        setState(() => selectedImageLink = null);
        widget.onClearImage();
      },
      style: TextButton.styleFrom(
        foregroundColor: ColorPallet.crimson,
      ),
      child: const Text("حذف عکس"),
    );
  }
}
