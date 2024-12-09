import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/media_page/media_list_item_leading.dart';

import '../../../media_exports.dart';

class MediaListItem extends StatefulWidget {
  final MediaEntity media;
  const MediaListItem({super.key, required this.media});

  @override
  State<MediaListItem> createState() => _MediaListItemState();
}

class _MediaListItemState extends State<MediaListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(widget.media.id.toString()),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: _leading(),
      title: _title(),
      subtitle: _subTitle(),
      trailing: _trailing(),
    );
  }

  Widget _leading() {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        border: Border.all(color: ColorPallet.border),
        borderRadius: BorderRadius.circular(smallCornerRadius),
      ),
      child: MediaListItemLeading(
        mimeType: widget.media.mimeType,
        sourceUrl: widget.media.sourceUrl,
      ),
    );
  }

  Widget _title() {
    return Text(
      widget.media.title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _subTitle() => Text(
        widget.media.date.toPersianDate(),
        style: Theme.of(context).textTheme.bodySmall,
      );

  Widget _trailing() {
    return PopupMenuButton(
      itemBuilder: (context) => [
        _editMenuItem(),
        _deleteMenuItem(),
      ],
    );
  }

  PopupMenuItem _editMenuItem() {
    return PopupMenuItem(
      key: const Key("edit_media"),
      value: "edit",
      onTap: () => Get.toNamed(editMediaScreenRoute, arguments: widget.media),
      child: const Row(
        textDirection: TextDirection.rtl,
        children: [
          Text("ویرایش", textAlign: TextAlign.right),
        ],
      ),
    );
  }

  PopupMenuItem _deleteMenuItem() {
    return PopupMenuItem(
      key: const Key("delete_media"),
      value: "delete",
      onTap: () {
        CustomDialogs.showAreYouSureDialog(
          context: context,
          title: "حذف رسانه",
          content:
              "آیا مطمئن هستید که میخواهید (${widget.media.title}) را برای همیشه حذف کنید؟",
          onConfirm: () {
            context.read<MediaCubit>().deleteMedia(widget.media.id);
          },
        );
      },
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Text("حذف برای همیشه", style: TextStyle(color: ColorPallet.crimson)),
        ],
      ),
    );
  }
}
