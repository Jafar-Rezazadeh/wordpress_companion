import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_handy_utils/extensions/widgets_separator_.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    show DateTimeExtensions, JalaliExt;
import 'package:wordpress_companion/core/core_export.dart';
import 'package:wordpress_companion/features/media/media_exports.dart';
import 'package:wordpress_companion/features/media/presentation/widgets/edit_media_screen/app_bar.dart';
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
        appBar: _appBar(),
        body: _body(),
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

  PushedPageAppBar _appBar() {
    return EditMediaScreenAppBar(
      context: context,
      mediaEntity: widget.mediaEntity,
      downloader: Downloader(),
      onSubmit: _updateMedia,
    ).build();
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

  Widget _body() {
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
          _link(),
          const Gap(100)
        ],
      ),
    );
  }

  Widget _fileShowBox() {
    return SizedBox(
      height: 0.6.sh,
      child: FileBoxBuilder(
        nextBuilder: ImageBoxBuilder(
          nextBuilder: VideoBoxBuilder(nextBuilder: null),
        ),
      ).build(
        mimetype: MimeTypeRecognizer.fromString(widget.mediaEntity.mimeType),
        sourceUrl: widget.mediaEntity.sourceUrl
            .replaceAll("https://localhost", "http://192.168.1.2"),
        //HACK: remove this replace on production
        label: widget.mediaEntity.title,
      ),
    );
  }

  Widget _detailsInfo() {
    return Column(
      children: [
        _publishDateInfo(),
        _authorInfo(),
        _fullNameInfo(),
        _typeInfo(),
        _sizeInfo(),
        _dimensionInfo(),
      ].withGapInBetween(10),
    );
  }

  Widget _publishDateInfo() {
    return _littleInfo(
      label: "تاریخ بارگذاری:",
      value: widget.mediaEntity.date.toJalali().formatFullDate(),
    );
  }

  Widget _authorInfo() {
    return _littleInfo(
      label: "بارگذاری شده توسط:",
      value: widget.mediaEntity.authorName ?? "نامشخص",
    );
  }

  Widget _fullNameInfo() {
    return _littleInfo(
      label: "نام:",
      value: widget.mediaEntity.sourceUrl.substring(
        widget.mediaEntity.sourceUrl.lastIndexOf("/") + 1,
      ),
    );
  }

  Widget _typeInfo() =>
      _littleInfo(label: "نوع پرونده:", value: widget.mediaEntity.mimeType);

  Widget _sizeInfo() {
    return _littleInfo(
      label: "اندازه:",
      value: filesize(widget.mediaEntity.mediaDetails.fileSize),
    );
  }

  Widget _dimensionInfo() {
    if (widget.mediaEntity.mediaDetails.height != null) {
      return _littleInfo(
        label: "ابعاد:",
        value:
            "${widget.mediaEntity.mediaDetails.height ?? ""} در ${widget.mediaEntity.mediaDetails.width ?? ""} پیکسل",
      );
    }
    return const SizedBox.shrink();
  }

  Widget _littleInfo({required String label, required String value}) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const Gap(5),
        Flexible(child: Text(value)),
      ],
    );
  }

  Form _inputs() {
    return Form(
      child: Column(
        children: [
          _altTextInput(),
          _titleInput(),
          _captionInput(),
          _descriptionInput(),
        ].withGapInBetween(20),
      ),
    );
  }

  CustomFormInputField _altTextInput() {
    return CustomFormInputField(
      label: "متن جایگزین",
      initialValue: altTextValue,
      onChanged: (value) => altTextValue = value,
    );
  }

  CustomFormInputField _titleInput() {
    return CustomFormInputField(
      label: "عنوان",
      initialValue: titleValue,
      onChanged: (value) => titleValue = value,
    );
  }

  CustomFormInputField _captionInput() {
    return CustomFormInputField(
      label: "توضیحات کوتاه",
      initialValue: captionValue,
      onChanged: (value) => captionValue = value,
    );
  }

  CustomFormInputField _descriptionInput() {
    return CustomFormInputField(
      label: "توضیحات",
      initialValue: descriptionValue,
      onChanged: (value) => descriptionValue = value,
      maxLines: 5,
    );
  }

  Widget _link() {
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
