import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:gap/gap.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    show DateTimeExtensions, JalaliExt;
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/utils/file_size.dart';
import 'package:wordpress_companion/core/utils/mime_type_recognizer.dart';
import 'package:wordpress_companion/features/media/domain/entities/media_entity.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/media_show_box.dart';

class EditMediaScreen extends StatelessWidget {
  final MediaEntity mediaEntity;
  const EditMediaScreen({super.key, required this.mediaEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  PushedPageAppBar _appBar(BuildContext context) {
    return PushedPageAppBar(
      context: context,
      title: "ویرایش رسانه",
      bottomLeadingWidgets: [
        SaveButton(
          onPressed: () {
            //TODO: get input values and update the media
          },
        )
      ],
      bottomActionWidgets: [
        _deleteButton(),
        _downloadButton(),
      ],
    );
  }

  IconButton _deleteButton() {
    return IconButton(
      onPressed: () {},
      color: ColorPallet.crimson,
      icon: const Icon(Icons.delete_outline),
    );
  }

  IconButton _downloadButton() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.file_download_outlined),
    );
  }

  Widget _body(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: edgeToEdgePaddingHorizontal,
          vertical: 20,
        ),
        children: [
          _fileShowBox(),
          const Gap(30),
          _detailsInfo(),
          const Gap(50),
          _inputs(),
          const Gap(30),
          _link(context),
          const Gap(100)
        ],
      ),
    );
  }

  Widget _fileShowBox() {
    return FileBoxBuilder(
      nextBuilder: ImageBoxBuilder(
        nextBuilder: VideoBoxBuilder(nextBuilder: null),
      ),
    ).build(
        mimetype: MimeTypeRecognizer.fromString(mediaEntity.mimeType),
        sourceUrl: mediaEntity.sourceUrl
            .replaceAll("https://localhost", "http://192.168.1.2"),
        label: mediaEntity.title

        //FIXME: remove this replace on production
        );
  }

  Widget _detailsInfo() {
    return Column(
      children: [
        _littleInfo(
          label: "تاریخ بارگذاری:",
          value: mediaEntity.date.toJalali().formatFullDate(),
        ),
        _littleInfo(
          label: "بارگذاری شده توسط:",
          value: mediaEntity.author.toString(),
        ),
        _littleInfo(
          label: "نام:",
          value: mediaEntity.sourceUrl.substring(
            mediaEntity.sourceUrl.lastIndexOf("/") + 1,
          ),
        ),
        _littleInfo(label: "نوع:", value: mediaEntity.mimeType),
        _littleInfo(
          label: "اندازه:",
          value: filesize(mediaEntity.mediaDetails.fileSize),
        ),
        if (mediaEntity.mediaDetails.height != null)
          _littleInfo(
            label: "ابعاد:",
            value:
                "${mediaEntity.mediaDetails.width ?? ""} در ${mediaEntity.mediaDetails.height ?? ""} پیکسل",
          ),
      ].withGapInBetween(5),
    );
  }

  Widget _littleInfo({required String label, required String value}) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Gap(5),
        Flexible(child: Text(value)),
      ],
    );
  }

  Form _inputs() {
    return Form(
      child: Column(
        children: [
          CustomFormInputField(
            label: "متن جایگزین",
            initialValue: mediaEntity.altText,
          ),
          CustomFormInputField(
            label: "عنوان",
            initialValue: mediaEntity.title,
          ),
          CustomFormInputField(
            label: "توضیحات کوتاه",
            initialValue: mediaEntity.caption,
          ),
          CustomFormInputField(
            label: "توضیحات",
            initialValue: mediaEntity.description,
            maxLines: 5,
          ),
        ].withGapInBetween(20),
      ),
    );
  }

  Widget _link(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: FilledButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: mediaEntity.sourceUrl));
          _showSnackBar(context);
        },
        child: const Text(
          "کپی کردن لینک رسانه ",
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Durations.extralong4,
        content: Text(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          "لینک کپی شد.",
        ),
      ),
    );
  }
}
