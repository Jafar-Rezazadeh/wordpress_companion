import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:gap/gap.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    show DateTimeExtensions, JalaliExt;
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/core/utils/file_size.dart';
import 'package:wordpress_companion/core/utils/mime_type_recognizer.dart';
import 'package:wordpress_companion/core/widgets/custom_dialogs.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/media_show_box.dart';

class EditMediaScreen extends StatefulWidget {
  final MediaEntity mediaEntity;

  const EditMediaScreen({super.key, required this.mediaEntity});

  @override
  State<EditMediaScreen> createState() => _EditMediaScreenState();
}

class _EditMediaScreenState extends State<EditMediaScreen> {
  late String altTextValue;
  late String titleValue;
  late String captionValue;
  late String descriptionValue;

  @override
  void initState() {
    altTextValue = widget.mediaEntity.altText;
    titleValue = widget.mediaEntity.title;
    captionValue = widget.mediaEntity.caption;
    descriptionValue = widget.mediaEntity.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MediaCubit, MediaState>(
      listener: _mediaStateListener,
      child: Scaffold(
        appBar: _appBar(context),
        body: _body(context),
      ),
    );
  }

  void _mediaStateListener(_, MediaState state) {
    state.whenOrNull(
      updated: () {
        if (Navigator.of(context).canPop()) {
          Navigator.pop(context);
        }
      },
    );
  }

  PushedPageAppBar _appBar(BuildContext context) {
    return PushedPageAppBar(
      context: context,
      title: "ویرایش رسانه",
      bottomLeadingWidgets: [_submitButton()],
      bottomActionWidgets: [
        _deleteButton(),
        _downloadButton(),
      ],
      showLoading: _isLoadingState(),
    );
  }

  SaveButton _submitButton() {
    return SaveButton(
      key: const Key("save_button"),
      onPressed: () => _updateMedia(),
    );
  }

  bool _isLoadingState() {
    return context.watch<MediaCubit>().state.whenOrNull(loading: () => true) ==
        true;
  }

  void _updateMedia() {
    context.read<MediaCubit>().updateMedia(
          UpdateMediaParams(
            id: widget.mediaEntity.id,
            altText: altTextValue,
            title: titleValue,
            caption: captionValue,
            description: descriptionValue,
          ),
        );
  }

  IconButton _deleteButton() {
    // TODO : write some test for this
    return IconButton(
      onPressed: () {
        CustomDialogs.showAreYouSureDialog(
          context: context,
          title: "حذف رسانه",
          content:
              "آیا مطمئن هستید که میخواهید (${widget.mediaEntity.title}) را برای همیشه حذف کنید؟",
          onConfirm: () {
            context.read<MediaCubit>().deleteMedia(widget.mediaEntity.id);
            Navigator.of(context).pop();
          },
        );
      },
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
      mimetype: MimeTypeRecognizer.fromString(widget.mediaEntity.mimeType),
      sourceUrl: widget.mediaEntity.sourceUrl
          .replaceAll("https://localhost", "http://192.168.1.2"),
      //FIXME: remove this replace on production
      label: widget.mediaEntity.title,
    );
  }

  Widget _detailsInfo() {
    return Column(
      children: [
        _littleInfo(
          label: "تاریخ بارگذاری:",
          value: widget.mediaEntity.date.toJalali().formatFullDate(),
        ),
        _littleInfo(
          label: "بارگذاری شده توسط:",
          value: widget.mediaEntity.authorName ?? "نامشخص",
        ),
        _littleInfo(
          label: "نام:",
          value: widget.mediaEntity.sourceUrl.substring(
            widget.mediaEntity.sourceUrl.lastIndexOf("/") + 1,
          ),
        ),
        _littleInfo(label: "نوع پرونده:", value: widget.mediaEntity.mimeType),
        _littleInfo(
          label: "اندازه:",
          value: filesize(widget.mediaEntity.mediaDetails.fileSize),
        ),
        if (widget.mediaEntity.mediaDetails.height != null)
          _littleInfo(
            label: "ابعاد:",
            value:
                "${widget.mediaEntity.mediaDetails.width ?? ""} در ${widget.mediaEntity.mediaDetails.height ?? ""} پیکسل",
          ),
      ].withGapInBetween(10),
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
            initialValue: altTextValue,
            onChanged: (value) => altTextValue = value,
          ),
          CustomFormInputField(
            label: "عنوان",
            initialValue: titleValue,
            onChanged: (value) => titleValue = value,
          ),
          CustomFormInputField(
            label: "توضیحات کوتاه",
            initialValue: captionValue,
            onChanged: (value) => captionValue = value,
          ),
          CustomFormInputField(
            label: "توضیحات",
            initialValue: descriptionValue,
            onChanged: (value) => descriptionValue = value,
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
        key: const Key("copy_link_button"),
        onPressed: () async {
          Clipboard.setData(ClipboardData(text: widget.mediaEntity.sourceUrl));
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
