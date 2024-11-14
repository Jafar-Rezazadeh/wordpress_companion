import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import '../../../../core/core_export.dart';
import '../../site_settings_exports.dart';

class SiteIconInput extends StatefulWidget {
  final int? initialImageId;
  final Function(int value) onSelect;
  const SiteIconInput({
    super.key,
    this.initialImageId,
    required this.onSelect,
  });

  @override
  State<SiteIconInput> createState() => _SiteIconInputState();
}

class _SiteIconInputState extends State<SiteIconInput> {
  MediaEntity? selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.initialImageId != null) {
      context.read<ImageFinderCubit>().findImage(widget.initialImageId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImageFinderCubit, ImageFinderState>(
      listener: _imageFinderStateListener,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("نمادک سایت:"),
          const Gap(10),
          _imageInput(context),
        ],
      ),
    );
  }

  void _imageFinderStateListener(_, ImageFinderState state) {
    state.whenOrNull(
      imageFound: (image) => setState(() => selectedImage = image),
    );
  }

  Widget _imageInput(BuildContext context) {
    return InkWell(
      key: const Key("site_icon_input"),
      onTap: () => _openSelectMedialDialog(context),
      borderRadius: BorderRadius.circular(smallCornerRadius),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorPallet.border),
          borderRadius: BorderRadius.circular(smallCornerRadius),
        ),
        height: 48,
        width: 48,
        child: selectedImage == null
            ? const Icon(Icons.image)
            : Image.network(
                selectedImage!.sourceUrl,
                errorBuilder: (context, error, stackTrace) => Icon(
                  key: const Key("error_icon"),
                  Icons.error,
                  color: ColorPallet.text,
                ),
              ),
      ),
    );
  }

  Future<void> _openSelectMedialDialog(BuildContext context) async {
    final MediaEntity? image = await context.push(imageSelectorRoute);

    if (image != null) {
      setState(() => selectedImage = image);
      if (selectedImage != null) {
        widget.onSelect(selectedImage!.id);
      }
    }
  }
}
